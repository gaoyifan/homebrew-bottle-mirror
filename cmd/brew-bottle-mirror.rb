require "formula"
require 'thread'

class ThreadPool
  class Worker
    def initialize
      @mutex = Mutex.new
      @thread = Thread.new do
        while true
          sleep 0.001
          block = get_block
          if block
            block.call
            reset_block
          end
        end
      end
    end
    
    def get_block
      @mutex.synchronize {@block}
    end
    
    def set_block(block)
      @mutex.synchronize do
        raise RuntimeError, "Thread already busy." if @block
        @block = block
      end
    end
    
    def reset_block
      @mutex.synchronize {@block = nil}
    end
    
    def busy?
      @mutex.synchronize {!@block.nil?}
    end
  end
  
  attr_accessor :max_size
  attr_reader :workers

  def initialize(max_size = 10)
    @max_size = max_size
    @workers = []
    @mutex = Mutex.new
  end
  
  def size
    @mutex.synchronize {@workers.size}
  end
  
  def busy?
    @mutex.synchronize {@workers.any? {|w| w.busy?}}
  end
  
  def join
    sleep 0.01 while busy?
  end
  
  def process(&block)
    wait_for_worker.set_block(block)
  end
  
  def wait_for_worker
    while true
      worker = find_available_worker
      return worker if worker
      sleep 0.01
    end
  end
  
  def find_available_worker
    @mutex.synchronize {free_worker || create_worker}
  end
  
  def free_worker
    @workers.each {|w| return w unless w.busy?}; nil
  end
  
  def create_worker
    return nil if @workers.size >= @max_size
    worker = Worker.new
    @workers << worker
    worker
  end
end


pool = ThreadPool.new(10)
mac = false
if ARGV[0] == "mac"
  mac = true
end

flist = File.new(HOMEBREW_CACHE/"filelist.txt", "w")
flist_lock = Mutex.new
Formula.core_files.each do |fi|
  pool.process do
    begin
      f = Formula[fi]
    rescue Exception => e
      opoo "#{fi}: something goes wrong."
      puts e.message
      puts e.backtrace.inspect
      next
    end
      
    next unless f.bottle_defined?

    bottle_spec = f.stable.bottle_specification
    bottle_spec.collector.keys.each do |os|
      if mac
        next if os == :x86_64_linux
      else
        next if os != :x86_64_linux
      end
      checksum = bottle_spec.collector[os]
      b = Bottle::Filename.create(f, os, bottle_spec.rebuild)
      filename = "#{b.name}-#{b.version}#{b.extname}"
      filename_url_encode = b.bintray
      puts "root_url: #{bottle_spec.root_url}, filename: #{filename}"
      flist_lock.synchronize {
        flist.puts filename
      }
      if ENV['HOMEBREW_TAP'].nil?
          root_url = bottle_spec.root_url
	      if !mac
	          # fix many linux package has wrong bottle root_url
	          root_url = "https://linuxbrew.bintray.com/bottles"
	      end
      else
          if ENV['HOMEBREW_BOTTLE_DOMAIN'].nil?
              root_url = "http://homebrew.bintray.com/bottles-#{ENV['HOMEBREW_TAP']}"
          else
              root_url = "#{ENV['HOMEBREW_BOTTLE_DOMAIN']}/bottles-#{ENV['HOMEBREW_TAP']}"
          end
      end
      url = "#{root_url}/#{filename_url_encode}"

      file = HOMEBREW_CACHE/filename
      tmpfile = HOMEBREW_CACHE/"#{filename}.tmp"
      next if File.exist?(file)

      begin
        curl "-sSL", "-m", "600", url, "-o", tmpfile
        tmpfile.verify_checksum(checksum)
      rescue ChecksumMismatchError => e
        FileUtils.rm_f tmpfile
        opoo "Checksum mismatch #{url}, #{e}"
        next
      rescue Exception => e
        FileUtils.rm_f tmpfile
        opoo "Failed to download #{url}, #{e}"
        next
      rescue Exception => e
        opoo "Unknown error #{e}"
        next
      end
      FileUtils.mv(tmpfile, file)
      ohai  "#{filename} downloaded"

      # for debug, avoid taking up disk space quickly
      # Kernel.exit(0)
    end
  end
end
pool.join
flist.close

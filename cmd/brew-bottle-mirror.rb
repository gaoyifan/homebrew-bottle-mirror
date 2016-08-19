require "formula"

mac = false
if ARGV[0] == "mac"
  mac = true
end

flist = File.new(HOMEBREW_CACHE/"filelist.txt", "w")
Formula.core_files.each do |fi|
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
      checksum = bottle_spec.collector[os][:checksum]
      b = Bottle::Filename.create(f, os, bottle_spec.rebuild)
      filename = "#{b.name}-#{b.version}#{b.extname}"
      filename_url_encode = b.bintray
      puts "root_url: #{bottle_spec.root_url}, filename: #{filename}"
      flist.puts filename
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
flist.close

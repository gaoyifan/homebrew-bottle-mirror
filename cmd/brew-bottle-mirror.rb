require "formula"

Formula.core_files.each do |fi|
  f = Formula[fi]
  next unless f.bottle_defined?

  bottle_spec = f.stable.bottle_specification
  bottle_spec.collector.keys.each do |os|
    checksum = bottle_spec.collector[os]
    next unless checksum.hash_type == :sha256
    filename = Bottle::Filename.create(f, os, bottle_spec.revision)
    url = "#{bottle_spec.root_url}/#{filename}"

    file = HOMEBREW_CACHE/filename
    FileUtils.rm_f file
    next if File.exist?("#{file}.checked")

    begin
      curl url, "-o", file
      file.verify_checksum(checksum)
    rescue ErrorDuringExecution
      opoo "Failed to download #{url}"
      FileUtils.rm_f file
      next
    rescue ChecksumMismatchError => e
      opoo e
      FileUtils.rm_f file
      next
    end
    FileUtils.touch("#{file}.checked")
    ohai  "#{filename} downloaded"

  end

end

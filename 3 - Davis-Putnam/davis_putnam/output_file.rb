class OutputFile
  def initialize(infile, out_path)
    @infile = infile
    @out_path = out_path
  end

  def write_atoms!(atoms)

    # write atoms
    File.open(@out_path, 'w') do |f|
      atoms.each do |atom|
        f.write atom[0]
        if atom[1] == true
          f.write " T\n"
        else
          f.write " F\n"
        end
      end
    end


    write_end_lines
  end

  private

  def write_end_lines
    lines = []

    @infile.file.each_line do |line|
      lines << line
    end

    puts lines

    File.open(@out_path, 'a') do |f|
      f.puts "0"
      lines.each do |line|
        f.puts(line)
      end
    end

  end

end

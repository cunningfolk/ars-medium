def init

  options.format = :md
  #options.delete(:objects)
  options.files.delete_if {|file| file.filename =~ /^README/ }
  options.files.each {|file| serialize_file(file)}

end

def serialize_file(file)
  outfile = file.name + '.md'
  p file.path
  p file.filename
  p file.contents
  options.file = file
  options.object = Registry.root
  p options.serializer.basepath
  p options.serializer.inspect
  p options.serializer.extension = 'md'
  Templates::Engine.with_serializer(outfile, options.serializer) do
    file.contents
  end
  options.delete(:file)
end

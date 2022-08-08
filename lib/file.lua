--- File utilities for saving and reading files
-- @module[kind=core] FileUtils

local file = {}

--- Reads a file and its contents.
-- @tparam string path The path to the file to read
-- @return string The file contents
function file.read(path)
  local f = fs.open(path, "r")
  local content = f.readAll()
  f.close()

  return content
end

--- Reads the JSON content of a file.
-- @tparam string path The path to the file to read
-- @return table The JSON content
function file.readJSON(path)
  return textutils.unserialiseJSON(file.read(path))
end

--- Writes to a file with the specified content.
-- @tparam string path The path to the file to read
-- @tparam string content The content to write to the file
function file.write(path, content)
  local f = fs.open(path, "w")
  f.write(content)
  f.close()
end

--- Writes the specified content to a file as JSON.
-- @tparam string path The path to the file to read
-- @tparam table content  he content to write to the file
function file.writeJSON(path, content)
  file.write(path, textutils.serialiseJSON(content))
end

return file
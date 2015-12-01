#!/usr/bin/env ruby -KU


  def puts_list(path, list)
    if list.kind_of?(String)
      puts_string(path, list)
    elsif list.kind_of?(Hash)
      puts_hash(path, list)
    elsif list.kind_of?(Array)
      puts_array(path, list)
    else
      puts "Hey Im not excepting things other than hashes, arrays, or strings at this time."
    end
  end

  def puts_hash(path, list)
    path1 = path
    list.each do |k, v|
      if list.keys[0] != k
        path = path1
      end
      k = remove_slash("#{k}")
      puts "#{k}"
      path = write_dir(path + "/#{k}")
      puts_list(path, v)
    end
  end

  def puts_array(path, list)
    list.each do |a|
      puts_list(path, a)
    end
  end

  def puts_string(path, list)
    list = remove_slash("#{list}")
    puts "#{list}"
    write_dir(path + "/#{list}")
  end

  def remove_slash(str)
    if str.match "/"
      str = str.gsub("/", "_")
    end
    return str
  end

  def write_dir(folder_name)
    Dir::mkdir(folder_name)
    folder_name
  end


  folders = {"key1"=>["aryitem1", "aryitem2",
                      {"nestedkey1"=>["nestedary/1", "nestedary2"]},
                      "aryitem3"],
             "key2"=>["aryitem4", "aryitem5",
                      {"nestedkey2"=>["nestedary3", "nestedary4"]},
                      "aryitem6"]}


  path = "/Users/jducharme/Desktop"
  Dir::chdir(path)

  puts_list(path,folders)
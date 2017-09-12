
@oldPrefix = "ABCDEFG" 	#旧的类前缀
@newPrefix = "GFEDCBA"	#新的类前缀

@pwd = Dir.pwd #当前路径

#更改project文件
def changeProject(path)
	project = `ls #{path} | grep .xcodeproj`.chomp
	projectPath = path+"#{project}/project.pbxproj"

	content = File.read projectPath
	content = content.gsub(@oldPrefix, @newPrefix)
	File.write projectPath, content
end

#更改类名前缀和类名引用
def changeClassPrefix(path)
	Dir.foreach path do |entry|
		if whetherToSkip entry
			next
		end

		#文件的完整路径
		filePath = path+"/"+entry

		if File.directory? filePath
			changeClassPrefix filePath
		end

		#只修改.h .m .xib .storyboard文件
		if entry.end_with? ".h" or entry.end_with? ".m" or entry.end_with? ".xib" or entry.end_with? ".storyboard"
			content = File.read filePath
			content = content.gsub(@oldPrefix, @newPrefix)
			File.write filePath, content
		end

		if entry.include? @oldPrefix
			oldPath = filePath
			newPath = path+"/"+entry.gsub(@oldPrefix, @newPrefix)
			File::rename oldPath, newPath
		end
	end
end

def whetherToSkip(entry)
  	if entry.start_with? "." or entry.end_with? "xcodeproj" or entry.start_with? "Pod" or entry.end_with? "framework" or entry.end_with? "xcworkspace" or entry.end_with? ".a" #以./~/Pod开头的文件或文件夹不处理. .. ..DS_Store
    	return true #跳过
  	end
  	false
end

if ARGV.count == 1 and File.exist? @pwd+"/"+ARGV[0]
	path = @pwd+"/"+ARGV[0]+"/" #工程项目的路径

	changeProject path
	changeClassPrefix path
else
	puts "请输入正确的项目名"
end
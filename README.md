# iOSClassChangePrefix

##类名替换前缀
###该脚本只适用于有统一类前缀且类前缀唯一的情况。如果当前没有统一的类前缀可参考[类名加前缀](https://github.com/709213219/iOSClassAddPrefix.git)先添加统一的类前缀。

###使用步骤：

###第一步：将iOSClassChangePrefix.rb拷贝到工程文件同目录下。

###第二步：打开iOSClassChangePrefix.rb文件，修改@oldPrefix和@newPrefix的值。(@oldPrefix为类当前前缀，@newPrefix为类新的前缀)

###第三步：终端cd到同目录下，运行 ruby iOSClassChangePrefix.rb YYModel (YYModel即为工程名)
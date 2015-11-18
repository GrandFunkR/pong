#*************************************************************************#
#*  global.gd                                                            *#
#*************************************************************************#
#* Copyright (c) 2015 Dario Iannaccone.                                  *#
#*                                                                       *#
#* Permission is hereby granted, free of charge, to any person obtaining *#
#* a copy of this software and associated documentation files (the       *#
#* "Software"), to deal in the Software without restriction, including   *#
#* without limitation the rights to use, copy, modify, merge, publish,   *#
#* distribute, sublicense, and#or sell copies of the Software, and to    *#
#* permit persons to whom the Software is furnished to do so, subject to *#
#* the following conditions:                                             *#
#*                                                                       *#
#* The above copyright notice and this permission notice shall be        *#
#* included in all copies or substantial portions of the Software.       *#
#*                                                                       *#
#* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,       *#
#* EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF    *#
#* MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.*#
#* IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY  *#
#* CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,  *#
#* TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE     *#
#* SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                *#
#*************************************************************************#
extends Node
var current_scene 	= null
var level = 1

func goto_scene(scene):

	if current_scene == null:
		if get_node("/root").has_node("splash"):
			current_scene = get_node("/root/splash")

	#load new scene
	var s = ResourceLoader.load(scene)
	if s==null:
		return false
		
	#queue erasing old (don't use free because that scene is calling this method)
	if current_scene != null:
		current_scene.queue_free()
	#instance the new scene
	current_scene = s.instance()
	
	#add it to the active scene, as child of root
	add_child(current_scene)
	
	return true

func gotoLevel(lvl, setLvl):
	var global = get_node("/root/global")
	
	if setLvl:
		level = lvl
		global.option_save("lastLevel",level)
		
		
	var loaded = goto_scene("res://scenes/level" + str(lvl) + "/level.xscn")
	if !loaded:
		gotoLevel(lvl-1, false)

func gotoSplash():
	goto_scene("res://scenes/splash/splash.xscn")

func option_load(key, default):
	var f = File.new()
	var err = f.open("user://options.txt",File.READ)
	if(err): # If the file doesn't exist, we try to write to it first
		f.close()
		return default
	
	var line = f.get_line()
	f.close()
	
	if line=="":
		return default
	
	var dic = {}
	dic.parse_json(line)
	
	if dic.has(key):
		return dic[key]
	else:
		return default
	
func option_save(key, value):
	var line = ""
	var f = File.new()
	var err = f.open("user://options.txt",File.READ)
	
	if(!err):
		line = f.get_line()
	f.close()
	
	var dic = {}
	
	if line!="":
		dic.parse_json(line)
	dic[key]=value
	line = dic.to_json()
	
	var err = f.open("user://options.txt",File.WRITE)
	if(!err):
		f.store_line(line)
	f.close()
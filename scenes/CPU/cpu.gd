#*************************************************************************#
#*  cpu.gd                                                               *#
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
extends StaticBody2D
var vel = 1


func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var pos = get_pos()
	var ballPos = get_parent().get_node("ball").get_pos()
	var deltapos = 0
	var friction = 1
	
	if ballPos.y>600:
		friction=2
		
	if pos.x > ballPos.x:
		pos.x -= vel
		deltapos=-vel
		if pos.x < ballPos.x:
			deltapos += (ballPos.x-pos.x)
			pos.x=ballPos.x
		
	elif pos.x < ballPos.x:
		pos.x += vel
		deltapos=vel
		
		if pos.x > ballPos.x:
			deltapos -= (pos.x-ballPos.x)
			pos.x=ballPos.x
			
		
		
	move_local_x((deltapos/friction)*delta*50)

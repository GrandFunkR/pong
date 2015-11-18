#*************************************************************************#
#*  pad.gd                                                               *#
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
extends KinematicBody2D
var m_newPos = Vector2(0,0)
const VEL = 1000


func _ready():
	m_newPos = get_pos()
	set_process_input(true)
	set_fixed_process(true)


func _fixed_process(delta):
	var pos = get_pos()
	var vel = VEL*delta
	
	if m_newPos.x-vel > pos.x:
		pos.x += vel
	elif m_newPos.x+vel < pos.x:
		pos.x -= vel
		
	set_pos(pos)


func _input(event):
	var t = event.type
	var click = (t == InputEvent.SCREEN_TOUCH) || (t == InputEvent.MOUSE_BUTTON) || (t == InputEvent.SCREEN_DRAG) || (t == InputEvent.MOUSE_MOTION)
	
	if (click):
		m_newPos= Vector2(event.x, event.y)
#*************************************************************************#
#*  game.gd                                                              *#
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

var pointCpu 		= 0
var pointPlayer		= 0
var global
const POINTS_TO_WIN = 3

func _ready():
	var ball = get_node("../ball")
	var cpu = get_node("../cpu")
	global = get_node("/root/global")
	
	ball.vel += (global.level*1.5)
	cpu.vel += global.level
	get_node("../lblLivello").set_text("Level " + str(global.level))
	
	reset()

func setPoint(point):
	if point>0:
		pointPlayer += 1
	else:
		pointCpu += 1
	
	var lblCpu = get_parent().get_node("lblCPU")
	var lblPlayer = get_parent().get_node("lblPlayer")
	
	lblCpu.set_text(str(pointCpu))
	lblPlayer.set_text(str(pointPlayer))
	
	reset()
	
	if pointPlayer >=POINTS_TO_WIN:
		youWin()
	elif pointCpu >=POINTS_TO_WIN:
		gameOver()
	
func reset():
	var ball = get_node("../ball")
	ball.reset()
	
	

func youWin():
	global.gotoLevel(global.level+1,true)

func gameOver():
	global.gotoSplash()




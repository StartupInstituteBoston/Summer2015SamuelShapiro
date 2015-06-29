require 'gosu'

class Sierpinski < Gosu::Window

#	def drawTriangle xco, yco, depth
#		@lines << 
#	end

	def initialize
		super 500, 500
		self.caption = "Sierpinski Triangle Ruby Script"
		@white = Gosu::Color::WHITE
		@y = 400 - (200 * Math.sqrt(3))
		@tris = []
		createTriangle(50, 400, 1)
	end

	def createTriangle x, y, depth
		tri = Triangle.new(x, y, depth)
		@tris << tri
		unless depth >= 6
			createTriangle(x, y, depth+1)
			createTriangle(tri.x2, tri.y2, depth+1)
			createTriangle(tri.xco+tri.len, tri.yco, depth+1)
		end
	end

	def draw
		draw_line(50, 400, @white, 450, 400, @white, 0)
		draw_line(50, 400, @white, 250, @y, @white, 0)
		draw_line(250, @y, @white, 450, 400, @white, 0)
		@tris.each do |tri|
			tri.lines.each do |line|
				draw_line(line[:x], line[:y], @white, line[:x2], line[:y2], @white, 0)
			end
		end
	end

end

class Triangle
	def initialize xco, yco, depth
		@xco, @yco = xco, yco
		@len = 400/(2**depth)
		@angle = (Math::PI/3)
		@x2 = xco + @len * Math.cos(@angle)
		@y2 = yco - @len * Math.sin(@angle)
		@lines = []
		@lines << {:x => @x2, :y => @y2, :x2 => @x2+@len, :y2 => @y2}
		@lines << {:x => @x2, :y => @y2, :x2 => @xco+@len, :y2 => @yco}
		@lines << {:x => @x2+@len, :y => @y2, :x2 => @xco+@len, :y2 => @yco}
		@trinews = []
	end

	attr_reader :x2, :y2, :xco, :yco, :len, :lines


end

window = Sierpinski.new
window.show
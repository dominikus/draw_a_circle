# main.coffee

# imports
#
#



# generic logging function
log = (args...) ->
	# if the browser has a console, log all passed arguments individually
	console?.log arg for arg in args 


# + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + 
# set up main app namespace

app        = window.app = {}

# prevent iOS scrolling
# document.ontouchmove = (event) ->
# 	event.preventDefault()

###
	begin
###

log "improved circle drawing"


setupCircleDrawer = (svg, defaultInteraction = true) ->
	background = svg.append('rect')
	.attr('x', 0)
	.attr('y', 0)
	.attr('width', 450)
	.attr('height', 450)
	.style('fill', 'aliceblue')

	backgroundCircle = svg.append('circle')
		.attr('cx', 225)
		.attr('cy', 225)
		.attr('r', 125)

	if defaultInteraction
		backgroundCircle.style('fill', 'crimson')
	else
		backgroundCircle.style('fill', 'blue')

	cGroup = svg.append('g')

	circle = cGroup.append('ellipse')
		.attr('cx', 0)
		.attr('cy', 0)
		.attr('rx', 50)
		.attr('ry', 50)
		.style('stroke-dasharray', '5,5')
		.style('stroke-width', '3')
		.style('stroke', 'rgb(0,0,0)')
		.style('fill', 'white')
		.style('opacity', 0.8)
		#.style('fill', 'rgba(255,0,0,0.9)')

	firstCircle = cGroup.append('circle')
		.attr('cx', -50)
		.attr('cy', 0)
		.attr('r', 3)
		.style('fill', 'white')

	middleCircle = cGroup.append('circle')
		.attr('cx', 0)
		.attr('cy', 0)
		.attr('r', 8)
		.style('fill', 'white')

	secondCircle = cGroup.append('circle')
		.attr('cx', 50)
		.attr('cy', 0)
		.attr('r', 3)
		.style('fill', 'white')

	if defaultInteraction
		iMouse = undefined
		lastMouse = undefined
		cCenter = [100,100]

		vector_length = (v) -> Math.sqrt(v[0] * v[0] + v[1] * v[1])

		mousedown = () ->
			d3.event.preventDefault()
			iMouse = d3.mouse(this)

		mousemove = () ->
			d3.event.preventDefault()
			if iMouse
				cMouse = d3.mouse(this)
				v = [cMouse[0] - iMouse[0], cMouse[1] - iMouse[1]]
				middle = [iMouse[0] + v[0] * 0.5, iMouse[1] + v[1] * 0.5]
				r = vector_length(v) / 2
				cGroup
					.attr('transform', "translate(#{middle[0]}, #{middle[1]})")
				circle
					.attr('rx', r)
					.attr('ry', r)
				firstCircle
					.attr('cx', iMouse[0] - middle[0])
					.attr('cy', iMouse[1] - middle[1])
				secondCircle
					.attr('cx', cMouse[0] - middle[0])
					.attr('cy', cMouse[1] - middle[1])
				cCenter = middle
			if lastMouse
				currentMouse = d3.mouse(svg[0][0])
				cCenter = currentMouse
				cGroup
					.attr('transform', "translate(#{cCenter[0]}, #{cCenter[1]})")
				lastMouse = currentMouse

		mouseup = () ->
			d3.event.preventDefault()
			iMouse = undefined
			lastMouse = undefined

		background
			.on('mousedown', mousedown)
			.on('touchstart', mousedown)
		backgroundCircle
			.on('mousedown', mousedown)
			.on('touchstart', mousedown)

		middleCircle
			.on('mousedown', () -> d3.event.preventDefault(); lastMouse = d3.mouse(this))
			.on('touchstart', () -> d3.event.preventDefault(); lastMouse = d3.mouse(this))

		svg
			.on('mousemove', mousemove)
			.on('mouseup', mouseup)
			.on('touchmove', mousemove)
			.on('touchend', mouseup)

	else
		iMouse = undefined
		lastMouse = undefined
		cCenter = [100,100]

		vector_length = (v) -> Math.sqrt(v[0] * v[0] + v[1] * v[1])

		mousedown = () ->
			d3.event.preventDefault()
			iMouse = d3.mouse(this)

		mousemove = () ->
			d3.event.preventDefault()
			if iMouse
				cMouse = d3.mouse(this)
				v = [cMouse[0] - iMouse[0], cMouse[1] - iMouse[1]]
				middle = [iMouse[0] + v[0] * 0.5, iMouse[1] + v[1] * 0.5]
				r = vector_length(v) / 2
				cGroup
					.attr('transform', "translate(#{middle[0]}, #{middle[1]})")
				circle
					.attr('rx', Math.abs(v[0] / 2))
					.attr('ry', Math.abs(v[1] / 2))
				firstCircle
					.attr('cx', iMouse[0] - middle[0])
					.attr('cy', iMouse[1] - middle[1])
				secondCircle
					.attr('cx', cMouse[0] - middle[0])
					.attr('cy', cMouse[1] - middle[1])
				cCenter = middle
			if lastMouse
				currentMouse = d3.mouse(svg[0][0])
				cCenter = currentMouse
				cGroup
					.attr('transform', "translate(#{cCenter[0]}, #{cCenter[1]})")
				lastMouse = currentMouse

		mouseup = () ->
			d3.event.preventDefault()
			iMouse = undefined
			lastMouse = undefined

		background
			.on('mousedown', mousedown)
			.on('touchstart', mousedown)
		backgroundCircle
			.on('mousedown', mousedown)
			.on('touchstart', mousedown)

		middleCircle
			.on('mousedown', () -> d3.event.preventDefault(); lastMouse = d3.mouse(this))
			.on('touchstart', () -> d3.event.preventDefault(); lastMouse = d3.mouse(this))

		svg
			.on('mousemove', mousemove)
			.on('mouseup', mouseup)
			.on('touchmove', mousemove)
			.on('touchend', mouseup)



# create first svg
svg = d3.select('#cont1').append('svg')
	.attr('width', 450)
	.attr('height', 450)

setupCircleDrawer(svg)


# create second svg
svg2 = d3.select('#cont2').append('svg')
	.attr('width', 450)
	.attr('height', 450)

setupCircleDrawer(svg2, false)

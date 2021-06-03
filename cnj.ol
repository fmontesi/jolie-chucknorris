#!/usr/bin/env jolie

from console import Console

service ChuckNorrisJoke {
	outputPort chuck {
		location: "socket://api.chucknorris.io:443/"
		protocol: https {
			osc.random << { method = "get" alias = "jokes/random" }
		}
		requestResponse: random
	}

	embed Console as console

	main {
		random@chuck()( joke )
		println@console( "🥋 " + joke.value )()
	}
}

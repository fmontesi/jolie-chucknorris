#!/usr/bin/env jolie

from console import Console

interface ChuckNorrisIface {
RequestResponse:
	random
}

service ChuckNorrisJoke {
	outputPort chuck {
		location: "socket://api.chucknorris.io:443/"
		protocol: https {
			osc.random << { method = "get" alias = "jokes/random" }
		}
		interfaces: ChuckNorrisIface
	}

	embed Console as console

	main {
		random@chuck()( joke )
		println@console( "🥋 " + joke.value )()
	}
}

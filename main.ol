/*
Copyright 2022 Fabrizio Montesi <famontesi@gmail.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

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
			osc.random << {
				method = "get"
				template = "jokes/random"
			}
		}
		interfaces: ChuckNorrisIface
	}

	embed Console as console

	main {
		random@chuck()( joke )
		println@console( "🥋 " + joke.value )()
	}
}

// Borrows heavily from https://github.com/grafana/grafonnet-lib/blob/master/grafonnet/dashboard.libsonnet

package grafana

#Dashboard: {
	#Annotation: {
		builtIn:    int | *1
		datasource: string | *"-- Grafana --"
		enable:     bool | *true
		hide:       bool | *true
		iconColor:  string | *"rgba(0, 211, 255, 1)"
		name:       string | *"Annotations & Alerts"
		type:       "dashboard"
	}

	#Duration: =~"((([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?|0)"

	#Templating: {
		list: [] // TODO
	}
	#Timepicker: {
		collapse:           bool | *false
		enable:             bool | *true
		notice:             bool | *false
		now:                bool | *true
		hidden:             bool | *false
		refresh_intervals?: [#Duration, ...#Duration] | *["5s", "10s", "30s", "1m", "5m", "15m", "30m", "1h", "2h", "1d"]
		status:             string
		type:               "timepicker" | *"dashboard"
	} | *{}

	annotations: {
		list: [#Annotation]
	}
	description?: !=""
	editable:     bool | *true
	gnetId:       null
	graphTooltip: 0 | 1 | 2 | *0
	hideControls: bool | *false
	id:           int | *1
	links:        [string, ...string] | *[]
	panels: [#Panel, ...#Panel]
	refresh:       string | *""
	schemaVersion: int | *25
	style:         "light" | *"dark"
	tags:          [string, ...string] | *[]
	templating:    #Templating
	time: {
		from: !="" | *"now-6h"
		to:   !="" | *"now"
	}
	timepicker: #Timepicker
	title:      !=""
	timezone:   "utc" | *"browser"
	uid:        !=""
	version:    int | *1
}

// Panel helper types
#Mode: "markdown" | *null

#Target: {
	expr:         !=""
	interval:     string | *""
	legendFormat: string | *""
	refId:        string | *""
}

// Panel type
#Panel: {
	#Content:    string | *null
	#DataSource: string | *"Prometheus"
	#FieldConfig: [string]: _
	#GridPos: {
		h: int | *8
		w: int | *12
		x: int | *0
		y: int | *0
	}
	#Legend: {
		avg:     bool | *false
		current: bool | *false
		max:     bool | *false
		min:     bool | *false
		show:    bool | *true
		total:   bool | *false
		values:  bool | *false
	}
	#Options: {
		alertThreshold: bool | *true
	}
	#Tooltip: {
		shared:     bool | *true
		sort:       int | *0
		value_type: string | *"individual"
	}
	#Xaxis: {
		buckets: [string, ...string] | *null
		mode:    "time"
		name:    string | *null
		show:    bool | *true
		values:  [string, ...string] | *[]
	}
	#Yaxis: {
		"$$hashkey"?: string
		format:       "short"
		label:        string | *null
		logBase:      int | *1
		max:          int | *null
		min:          int | *null
		show:         bool | *true
	}

	aliasColors: {}
	bars:          bool | *false
	dashLength:    int | *10
	dashes:        bool | *false
	datasource:    #DataSource
	description:   string | *""
	fieldConfig:   #FieldConfig
	fill:          int | *1
	fillGradient:  int | *0
	gridPos?:      #GridPos
	hiddenSeries:  bool | *false
	id:            >0
	legend:        #Legend
	lines:         bool | *true
	linewidth:     int | *1
	nullPointMode: string | *"null"
	options:       #Options
	percentage:    bool | *false
	pluginVersion: string | *"7.2.1"
	pointradius:   int | *2
	points:        bool | *false
	rendered:      string | *"flot"
	seriesOverrides: []
	spaceLength: int | *10
	stack:       bool | *false
	steppedLine: bool | *false
	targets?: [#Target, ...#Target]
	thresholds: []
	timeFrom:    string | *null
	timeRegions: [string, ...string] | *[]
	timeShift:   string | *null
	title?:      string
	tooltip:     #Tooltip
	type:        !=""
	xaxis:       #Xaxis
	yaxes:       [#Yaxis, ...#Yaxis] | *[#Yaxis, #Yaxis]
	yaxis: {
		align:      bool | *false
		alignLevel: string | *null
	}
	content: #Content
	... // Allow for additional fields in overlay types
}

// Legend format helpers
#ComponentLegend: "{{component_type}} {{component_kind}}: {{component_name}}"

// Specific panel types (inherited from #Panel)
#BarGauge: #Panel & {
	type:  "bargauge"
	title: !=""
	fieldConfig: {
		defaults: {
			unit?: string
			thresholds: {
				mode: "absolute"
				steps?: [string, ...string]
			}
		}
	}
}

#Graph: #Panel & {
	type:        "graph"
	transparent: bool | *false
	fieldConfig: {
		defaults: custom: {}
		overrides: []
	}
}

#Text: #Panel & {
	type: "text"
	mode: #Mode
}

#Dashboard & {
	title:       "Vector + Splunk"
	description: "A cost-cutting experiment"
	uid:         "vector-splunk"
	editable:    true
	time: {
		from: "now-5m"
		to:   "now"
	}
	panels: [
		#Graph & {
			id:          1
			title:       "Cost-cutting method comparison"
			description: "Byte processing throughput for the original raw stream vs. the trimmed stream (fields remove) vs. sampled (rate of 1/10)"
			gridPos: {
				h: 8
				w: 12
				x: 0
				y: 0
			}
			targets: [
				#Target & {
					expr:         "rate(vector_processed_bytes_total{component_kind!=\"\"}[10s])"
					legendFormat: #ComponentLegend
				},
			]
		},
	]
}

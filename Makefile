generate-dashboard:
	cue fmt grafana/*.cue
	cue export grafana/grafana.cue > grafana/provisioning/dashboards/vector-splunk.json
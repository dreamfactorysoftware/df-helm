{{/* templates/_helpers.tpl */}}

{{- define "dreamfactory.fullname" -}}
{{- printf "%s-%s" .Release.Name "dreamfactory" | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "mysql.fullname" -}}
{{- printf "%s-%s" .Release.Name "mysql" | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "redis.fullname" -}}
{{- printf "%s-%s" .Release.Name "redis" | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "logstash.fullname" -}}
{{- printf "%s-%s" .Release.Name "logstash" | trunc 63 | trimSuffix "-" -}}
{{- end }}


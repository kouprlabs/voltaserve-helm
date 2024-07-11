{{/*
Expand the name of the chart.
*/}}
{{- define "voltaserve.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "voltaserve.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "voltaserve.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "voltaserve.commonLabels" -}}
helm.sh/chart: {{ include "voltaserve.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Deployment specific labels
*/}}
{{- define "voltaserve-api.labels" -}}
{{ include "voltaserve.commonLabels" . }}
{{ include "voltaserve-api.selectorLabels" . }}
{{- end }}
{{- define "voltaserve-conversion.labels" -}}
{{ include "voltaserve.commonLabels" . }}
{{ include "voltaserve-conversion.selectorLabels" . }}
{{- end }}
{{- define "voltaserve-ui.labels" -}}
{{ include "voltaserve.commonLabels" . }}
{{ include "voltaserve-ui.selectorLabels" . }}
{{- end }}
{{- define "voltaserve-idp.labels" -}}
{{ include "voltaserve.commonLabels" . }}
{{ include "voltaserve-idp.selectorLabels" . }}
{{- end }}
{{- define "voltaserve-language.labels" -}}
{{ include "voltaserve.commonLabels" . }}
{{ include "voltaserve-language.selectorLabels" . }}
{{- end }}
{{- define "voltaserve-mosaic.labels" -}}
{{ include "voltaserve.commonLabels" . }}
{{ include "voltaserve-mosaic.selectorLabels" . }}
{{- end }}
{{- define "voltaserve-webdav.labels" -}}
{{ include "voltaserve.commonLabels" . }}
{{ include "voltaserve-webdav.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "voltaserve-api.selectorLabels" -}}
app.kubernetes.io/name: {{ include "voltaserve.name" . }}-api
app.kubernetes.io/instance: {{ .Release.Name }}-api
{{- end }}
{{- define "voltaserve-conversion.selectorLabels" -}}
app.kubernetes.io/name: {{ include "voltaserve.name" . }}-conversion
app.kubernetes.io/instance: {{ .Release.Name }}-conversion
{{- end }}
{{- define "voltaserve-ui.selectorLabels" -}}
app.kubernetes.io/name: {{ include "voltaserve.name" . }}-ui
app.kubernetes.io/instance: {{ .Release.Name }}-ui
{{- end }}
{{- define "voltaserve-idp.selectorLabels" -}}
app.kubernetes.io/name: {{ include "voltaserve.name" . }}-idp
app.kubernetes.io/instance: {{ .Release.Name }}-idp
{{- end }}
{{- define "voltaserve-language.selectorLabels" -}}
app.kubernetes.io/name: {{ include "voltaserve.name" . }}-language
app.kubernetes.io/instance: {{ .Release.Name }}-language
{{- end }}
{{- define "voltaserve-mosaic.selectorLabels" -}}
app.kubernetes.io/name: {{ include "voltaserve.name" . }}-mosaic
app.kubernetes.io/instance: {{ .Release.Name }}-mosaic
{{- end }}
{{- define "voltaserve-webdav.selectorLabels" -}}
app.kubernetes.io/name: {{ include "voltaserve.name" . }}-webdav
app.kubernetes.io/instance: {{ .Release.Name }}-webdav
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "voltaserve.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "voltaserve.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
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
Create the component specific names.
We truncate the common name more because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "voltaserve-api.fullname" -}}
{{- printf "%s-api" ( include "voltaserve.fullname" . | trunc 50 ) }}
{{- end }}
{{- define "voltaserve-console.fullname" -}}
{{- printf "%s-console" ( include "voltaserve.fullname" . | trunc 50 ) }}
{{- end }}
{{- define "voltaserve-idp.fullname" -}}
{{- printf "%s-idp" ( include "voltaserve.fullname" . | trunc 50 ) }}
{{- end }}
{{- define "voltaserve-ui.fullname" -}}
{{- printf "%s-ui" ( include "voltaserve.fullname" . | trunc 50 ) }}
{{- end }}
{{- define "voltaserve-language.fullname" -}}
{{- printf "%s-language" ( include "voltaserve.fullname" . | trunc 50 ) }}
{{- end }}
{{- define "voltaserve-conversion.fullname" -}}
{{- printf "%s-conversion" ( include "voltaserve.fullname" . | trunc 50 ) }}
{{- end }}
{{- define "voltaserve-mosaic.fullname" -}}
{{- printf "%s-mosaic" ( include "voltaserve.fullname" . | trunc 50 ) }}
{{- end }}
{{- define "voltaserve-webdav.fullname" -}}
{{- printf "%s-webdav" ( include "voltaserve.fullname" . | trunc 50 ) }}
{{- end }}
{{- define "voltaserve-migrations.fullname" -}}
{{- printf "%s-migrations" ( include "voltaserve.fullname" . | trunc 50 ) }}
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
{{- define "voltaserve-console.labels" -}}
{{ include "voltaserve.commonLabels" . }}
{{ include "voltaserve-console.selectorLabels" . }}
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
{{- define "voltaserve-migrations.labels" -}}
{{ include "voltaserve.commonLabels" . }}
{{ include "voltaserve-webdav.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "voltaserve.selectorLabels" -}}
app.kubernetes.io/name: {{ include "voltaserve.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- define "voltaserve-api.selectorLabels" -}}
{{ include "voltaserve.selectorLabels" . }}
app.kubernetes.io/component: api
{{- end }}
{{- define "voltaserve-console.selectorLabels" -}}
{{ include "voltaserve.selectorLabels" . }}
app.kubernetes.io/component: console
{{- end }}
{{- define "voltaserve-conversion.selectorLabels" -}}
{{ include "voltaserve.selectorLabels" . }}
app.kubernetes.io/component: conversion
{{- end }}
{{- define "voltaserve-ui.selectorLabels" -}}
{{ include "voltaserve.selectorLabels" . }}
app.kubernetes.io/component: ui
{{- end }}
{{- define "voltaserve-idp.selectorLabels" -}}
{{ include "voltaserve.selectorLabels" . }}
app.kubernetes.io/component: idp
{{- end }}
{{- define "voltaserve-language.selectorLabels" -}}
{{ include "voltaserve.selectorLabels" . }}
app.kubernetes.io/component: language
{{- end }}
{{- define "voltaserve-mosaic.selectorLabels" -}}
{{ include "voltaserve.selectorLabels" . }}
app.kubernetes.io/component: mosaic
{{- end }}
{{- define "voltaserve-webdav.selectorLabels" -}}
{{ include "voltaserve.selectorLabels" . }}
app.kubernetes.io/component: webdav
{{- end }}
{{- define "voltaserve-migrations.selectorLabels" -}}
{{ include "voltaserve.selectorLabels" . }}
app.kubernetes.io/component: migrations
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

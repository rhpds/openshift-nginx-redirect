{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "openshift-nginx-redirect.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "openshift-nginx-redirect.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "openshift-nginx-redirect.labels" -}}
helm.sh/chart: {{ include "openshift-nginx-redirect.chart" . }}
{{ include "openshift-nginx-redirect.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "openshift-nginx-redirect.selectorLabels" -}}
app.kubernetes.io/name: {{ include "openshift-nginx-redirect.name" . }}
{{-   if (ne (lower .Release.Name) "release-name") }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{-   end -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "openshift-nginx-redirect.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "openshift-nginx-redirect.name" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the namespace to use
*/}}
{{- define "openshift-nginx-redirect.namespaceName" -}}
{{- if .Values.namespace.create -}}
    {{ default (include "openshift-nginx-redirect.name" .) .Values.namespace.name }}
{{- else -}}
    {{ default "default" .Values.namespace.name }}
{{- end -}}
{{- end -}}

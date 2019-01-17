<#ftl output_format="XML" auto_esc=true>
<#--
  ~ Licensed to the Apache Software Foundation (ASF) under one
  ~ or more contributor license agreements.  See the NOTICE file
  ~ distributed with this work for additional information
  ~ regarding copyright ownership.  The ASF licenses this file
  ~ to you under the Apache License, Version 2.0 (the
  ~ "License"); you may not use this file except in compliance
  ~
  ~   http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing,
  ~ software distributed under the License is distributed on an
  ~ "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  ~ KIND, either express or implied.  See the License for the
  ~ specific language governing permissions and limitations
  ~ under the License.
  -->
<#attempt>
  <#assign profile = pp.loadData('json', 'Takeout/Profile/Profile.json')>
  <#recover>
    <#stop "NO_PROFILE_INFORMATION">
</#attempt>
<#if BASE_URI??>
@prefix : <${BASE_URI}> .
@base <${BASE_URI}> .
<#else>
@base <http://streams.apache.org/streams-contrib/streams-provider-youtube/> .
@prefix : <http://streams.apache.org/streams-contrib/streams-provider-youtube/> .
</#if>
<#if PREFIXES??>
@prefix as: <http://www.w3.org/ns/activitystreams#> .
@prefix apst: <http://streams.apache.org/ns#> .
@prefix dc: <http://purl.org/dc/elements/1.1/#> .
@prefix dct: <http://purl.org/dc/terms/#> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix vcard: <http://www.w3.org/2006/vcard/ns#> .
@prefix xs: <http://www.w3.org/2001/XMLSchema#> .
</#if>
<#if ID??>
  <#assign id="${ID}">
<#else>
  <#if profile_information.profile.name?is_hash>
    <#assign fullname=profile_information.profile.name.full_name>
  <#else>
    <#assign fullname=profile_information.profile.name>
  </#if>
  <#attempt>
    <#assign raw=profile.name.formattedName>
    <#assign id=raw?replace("\\W","","r")>
    <#recover>
      <#stop "NO_ID">
  </#attempt>
</#if>

# profile.json
:${id} a apst:YouTubeProfile .

:${id}
  as:displayName "${profile.displayName}" ;
  vcard:fn "${profile.name.formattedName}" ;
  vcard:given-name "${profile.name.givenName}" ;
  vcard:fn "${profile.name.familyName}" ;
  .

<#if profile.email??>
:${id}
  vcard:email "mailto:${profile.email}" ;
  .
</#if>

<#if profile.phone_number??>
:${id}	
  vcard:tel "tel:${profile.phone_number}" ;
  .
</#if>




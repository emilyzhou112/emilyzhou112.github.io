---
layout: page
title: Water Amenity Accessibility in Dar es Salaam Under Flood Scenario
---

Emily Zhou, Middlebury College  

Version 1.0 | Created 2021-10-07 | Last Updated 2021-10-11  

## Abstract

Many developing countries are facing water accessibility crisis under climate change. Structural poverty, high population density, poor municipal infrastructure, and factors of many other kinds have been continuously compounding this problem. This analysis examines resilience and vulnerability to flood in the city of Dar es Salaam in terms of households’ access to water amenities. Using data from Resilience Academy and Open Street Map, the analysis demonstrates that significant number of households in Dar es Salaam do not have access to water during flood. It also illustrates how uneven population and water amenity distribution are the primary reason responsible for such vulnerability.

### Keywords

*Vulnerability and Resilience, Water Accessibility, Flood Hazard, Dar es Salaam*


## Introduction



Water is an essential resource for life, and whose adequate access is recognized as basic a human right under the [United Nations’ Sustainable Development Goal](https://www.unwater.org/water-facts/human-rights/). While water access is generally measured by the distance to a source of water, this concept overlooks important issues such as the reliability, quality, and quantity. In many developing countries, citizen’s access to reliable and safe water remains a challenge, and the reality gets more disheartening when the issue of water quality is considered. The city of Dar es Salaam in Tanzania manifests one of these water accessibility crises. A significant proportion of Dar es Salaam’s population has no adequate access to water supply because of old infrastructure and poor public services. This problem is compounded by the increase in population density and informal settlements. Concurrently, the city is vulnerable to natural hazards, especially flood, that contaminates the already fragile and unstable water supply system. Although solving this crisis in Dar es Salaam is a time-consuming and thorny process that requires efforts from multiple sources, it is always helpful to first identify the crisis and visualize its spatial patterns to allow for future planning, resource allocation, and resilience building. This leads to the guiding question of this analysis: What percentage of households in each administrative wards in Dar es Salaam have their access to the nearest water amenity affected during flood?

## Study design

We need the following spatial features of Dar es Salaam in order to answer the question above: the administrative wards, the area of flood extent, the location of water amenities and residential buildings.

Among those features, residential buildings are used as a proxy for population for the ease of calculating summary statistics. All types of public water sources, such as water wells and taps, are counted as water amenities. To assess which water amenities are affected during flood, we need to compare it with the flood extent and highlight those water amenities that are within the flood zone. We assume that people would always use the water amenity that are closest to them and that each water amenity has its own service area. If a particular water amenity is damaged during flood, then all households within its service area are considered to have their water access affected. As such, we then need to compare residential buildings with the service area of each water amenity to learn the total number of households located in particular service areas, whose water amenity would be affected by flood.

Representing water accessibility using administrative wards as the geographic unit better allows us to visualize the spatial pattern of water accessibility under flood. To do so, we further compare the residential buildings with wards to summarize the total number of households in each ward as well as households facing water accessibility crisis.

A full description of how each step is achieved can be found in the next section. You may find this workflow diagram helpful for understanding the study design.

![wf](assets/dsm_workflow.jpeg)


## Materials and procedure

### Data and variables




### Geographic characteristics

Describe the **temporal** and **geographic characteristics** of the study, including its **temporal extent**, **temporal granularity**, **coordinate reference systems** and **spatial extent**. Are there any **edge effects** or complications from integrating data with different **spatial supports** or **resolutions**?

### Data transformations

Describe any **geographic** or **variable** transformations to be applied to data prior to the main analysis (preprocessing steps required to prepare the data for analysis). If any challenges with edge effects or conflicting spatial supports were identified above, enumerate steps to resolve the issues here.

If any data is to be **excluded** from the analysis, explain the rationale and methods for exclusion.

### Analysis

Describe the main analysis of the study, e.g. the steps for testing the hypotheses or answering the main research questions.

## Results

Objectively present the results of the study without additional interpretation.

## Discussion

Provide a summary the key findings of the study along with any limitations or areas in need of further investigation. If the study did not succeed as expected, discuss likely practical procedural and informative causes. Practical procedural causes relate to problems in the research procedures, e.g. challenges with data, code, or research parameters. Informative causes relate to problems with the referent geographic phenomena, e.g. absence of the theorized effect(s), change in population, or change in location.

## Conclusions

What are the broader implications of the research results for the environment or society? Do the results suggest the need for future research?

## References

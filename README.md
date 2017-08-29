# SQL-on-SCRIT-project

### Introduction

The small database consists of two datasets.

One of the datasets comes from the Land and Information New Zealand (LINZ), which is a New
Zealand government organisation. LINZ responsibilities include managing land titles, geodetic
and cadastral survey systems, topographic information, hydrographic information, managing
Crown property and supporting government decision making around foreign ownership. The
LINZ dataset used in this assignment is a comprehensive list of New Zealand addresses.

The other dataset comes from Stronger Christchurch Infrastructure Rebuild Team (SCIRT)
Project. SCIRT goal is to creat resilient infrastructure that gives people security and 
confidence in the future of Christchurch. SCIRT is an alliance between owner and non-owner 
participant organisations, comprising both government agencies and companies.


### About this script

#### 2.
* What is the total number of addresses in the nz_streets database?
* What is the total number of towns/cities in the nz_streets database?
* Show the details of the University of Canterbury address which is 20 Kirkwood Ave.
* Show all localities even if they are not linked to towns/cities.
* Show all routes in all localities linked to towns/cities.

#### 3.
Import the SCIRT dataset into a table prepared for this dataset. In order to perform this task,
a SCIRT_jobs table is created for the imported data.

#### 4.
The SCIRT dataset combines multiple streets in the routes (streets) field. it is required to normalise 
the dataset by extracting the routes field into a separate table, with a single route per row and a 
foreign key linking the rows in this table to the SCIRT_job table. 

#### 5.
* Which of the SCIRT delivery teams has the most number of SCIRT jobs assigned to it?
* Show all localities from the S CRIT_job table which do not have a corresponding
entry in the linz_streets database, l ocality table.
* Show all routes from the SCIRT_job_route table which do not have a
corresponding entry in the l inz_streets database, r oute table.
* Write a query to produce a list of localities from the S CIRT_job table with the
associated number of SCIRT jobs carried out in this locality.
* Write a query to return all address ids associated with City Care delivery team’s
work in Dublin Street.

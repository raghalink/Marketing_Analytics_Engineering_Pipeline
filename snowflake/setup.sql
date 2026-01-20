--- Create necessary warehouse, database, and schemas
create warehouse if not exists criteo
 warehouse_size = 'XSMALL'
 auto_suspend = 60
 auto_resume = true
 initially_suspended = true
 
use role SYSADMIN;
create database if not exists MARKETING_DB;
create schema if not exists MARKETING_DB.RAW;
create schema if not exists MARKETING_DB.ANALYTICS;

use warehouse criteo;
use database MARKETING_DB;
use schema MARKETING_DB.RAW;
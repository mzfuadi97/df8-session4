{{
    config(
        materialized='table'
    )
}}


with payment_type as (

    select
        id as id_payment,
        approach
        

    from `weighty-diorama-365805`.session4.payment_type 

),

taxi_zone as (

    select
        LocationID,
        Borough,
        Zone
        service_zone

    from `weighty-diorama-365805`.session4.taxi_zone 

),

vendors as (

    select
        id as VendorID,
	name

    from `weighty-diorama-365805`.session4.vendors 


),

final_rate_code as (

    select
        id as RatecodeID,
	end_trip

    from `weighty-diorama-365805`.session4.final_rate_code 


),

yellow_jan2019 as (

    select
        VendorID,
	tpep_dropoff_datetime - tpep_pickup_datetime as trip_datetime,
	passenger_count,
	trip_distance,
	RatecodeID,
	PULocationID,
	DOLocationID,
	payment_type,
	total_amount
	
	from `weighty-diorama-365805`.session4.yellow_jan2019 
),

yelow_tax_jan2019 as (

    select
	vendors.name as name_vendor,
	tpep_dropoff_datetime - tpep_pickup_datetime as trip_datetime,
	passenger_count,
	trip_distance,
	final_rate_code.end_trip as finalcode_endtrip,
    taxi_zone.Zone as PU_zone,
	taxi_zone.Zone as DO_zone,
	payment_type.approach as approach,
	total_amount

    from `weighty-diorama-365805`.session4.yellow_jan2019

left join `weighty-diorama-365805`.session4.vendors 
    on yellow_jan2019.VendorID = vendors.id
left join `weighty-diorama-365805`.session4.final_rate_code 
    on yellow_jan2019.RatecodeID = final_rate_code.id
left join `weighty-diorama-365805`.session4.taxi_zone 
    on yellow_jan2019.PULocationID = taxi_zone.LocationID
left join `weighty-diorama-365805`.session4.payment_type 
    on yellow_jan2019.payment_type = payment_type.id
)

select * from yelow_tax_jan2019
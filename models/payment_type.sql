{{
    config(
        materialized='table'
    )
}}


    select
        id as id_payment,
        approach
        

    from `weighty-diorama-365805`.session4.payment_type 


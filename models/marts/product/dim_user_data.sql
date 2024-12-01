SELECT
    user_id,
    first_name,
    last_name,
    email,
    phone_number,
    created_at_utc,
    dim_addresses.address_id,
    dim_addresses.address_desc,
    dim_addresses.zipcode,
    dim_addresses.country,
    dim_addresses.state,
FROM {{ref("dim_users")}} dim_users
INNER JOIN {{ref("dim_addresses")}} dim_addresses
    ON dim_users.address_id = dim_addresses.address_id
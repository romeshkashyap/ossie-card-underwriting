-- S1 smoke test: proves dbt can build into the warehouse. Safe to delete after S6.
select
    'ossie-card-underwriting' as project,
    current_date as checked_on

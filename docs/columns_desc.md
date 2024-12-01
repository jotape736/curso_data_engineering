{% docs order_status %}
	
One of the following values: 

| status         | definition                                       |
|----------------|--------------------------------------------------|
| preparing      | Order in preparation, not yet shipped            |
| shipped        | Order has been shipped, not yet been delivered   |
| delivered      | Order has been received by customers             |

{% enddocs %}

{% docs event_types %}

The following values represent different event types:

| event_type      | definition                                                                                           |
|-----------------|--------------------------------------------------|
| checkout        |  User is in checkout page.                       |                         
| package_shipped |  User is checking his package status.            |
| add_to_cart     |  User added a product to his cart.               |
| page_view       |  User is wiewing a product's page.               |

{% enddocs %}




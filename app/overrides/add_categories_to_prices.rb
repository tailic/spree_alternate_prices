virtual_path = 'spree/admin/prices/_variant_prices'
virtual_path_index = 'spree/admin/prices/index'

# Add header for default
Deface::Override.new(virtual_path: virtual_path_index,
                     name: 'add_batch_fields',
                     insert_before: 'fieldset',
                     text: %q{
                     	<div id="batchprices" class="row" style="background:#eee;">
<h5>Preise für alle Varianten ändern</h5>
	  <% categories = Spree::PriceCategory.all %>
	    <div class="omega four columns">
				<h5 class="twelve columns" style="margin:0;">&nbsp;</h5>
	      <h6>Verkaufspreis</h6>
	      <% supported_currencies.each do |currency| %>
	        <div class="field">
	          <% tag_name = "batchprice_#{currency.iso_code}" %>
	          <%= label_tag tag_name, currency.iso_code %>
	          <%= text_field_tag(tag_name, '', class: 'batchprice', data: {selector: ".vp_#{currency.iso_code}"}) %>
	        </div>
	      <% end %>
	    </div>
	  <% categories.each do |category| %>
	    <div class="omega four columns">
				<h5 class="twelve columns" style="margin:0;">&nbsp;</h5>
	      <h6><%= category.name.titleize %></h6>
	      <% supported_currencies.each do |currency| %>
	        <div class="field">
	          <% tag_name = "batchprice_#{currency.iso_code}_#{category.name}" %>
	          <%= label_tag tag_name, currency.iso_code %>
	          <%= text_field_tag(tag_name, '', class: 'batchprice', data: {selector: ".vpc_#{currency.iso_code}_#{category.name}"}) %>
	        </div>
	      <% end %>
	    </div>
	  <% end %>
<div class="omega four columns">
 <h5 class="twelve columns" style="margin:0;">&nbsp;</h5>
  <h6>&nbsp;</h6>
  <div class="field">
    <a class="button" id="batch-confirm">Übernehmen</a>
  </div>
</div>
<div class="omega four columns">
 <h5 class="twelve columns" style="margin:0;">&nbsp;</h5>
  <h6>&nbsp;</h6>
  <div class="field">
    <small>Die Preise werden 1:1 auf alle Varianten übernommen (auch leere Felder). Speichern nicht vergessen!</small>
  </div>
</div>
<script>
  $('#batch-confirm').click(function(){
    $('#batchprices .batchprice').each(function() {
      var $this = $(this);
      var selector = $this.data('selector');
      $(selector).val($this.val());
    });
  });
</script>
</div>
                     }
)

# Add header for default
Deface::Override.new(virtual_path: virtual_path,
	name: 'add_default_headers',
	insert_after: 'h5',
	text: %q{
		<% if Spree::PriceCategory.all.any? %>
			<h6>&nbsp;</h6>
		<% end %>
	},
	original: '8139694f91be91576dccbb8949d605f677afb828'
)

# Append categories w/ header
Deface::Override.new(virtual_path: virtual_path,
	name: 'append_categories',
	insert_after: 'div.omega',
	text: %q{
	<div class="row">
	  <% categories = Spree::PriceCategory.all %>
	  <% categories.each do |category| %>
	    <div class="omega four columns">
				<h5 class="twelve columns" style="margin:0;">&nbsp;</h5>
	      <h6><%= category.name.titleize %></h6>
	      <% supported_currencies.each do |currency| %>
	        <% price = variant.price_in(currency.iso_code, category) %>
	        <div class="field">
	          <% tag_name = "vpc[#{variant.id}][#{currency.iso_code}][#{category.name}]" %>
	          <%= label_tag tag_name, currency.iso_code %>
	          <%= text_field_tag(tag_name, (price && price.price ? price.display_amount.money : ''), class: "vpc_#{currency.iso_code}_#{category.name}") %>
	        </div>
	      <% end %>
	    </div>
	  <% end %>
<hr class="twelve columns">
</div>

	},
	original: '869cab3c38208e1276b94e81b604467e14fb5284'
)
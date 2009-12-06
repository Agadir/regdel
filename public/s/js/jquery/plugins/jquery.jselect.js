/**
* jQuery jSelect plugin
* @requires jQuery v1.2+
* @licenses	Creative Commons BY-SA [ http://creativecommons.org/licenses/by-sa/2.0/deed.fr ]
*
* @name		jSelect
* @desc		Plugin jQuery that enable load and add Option in Select
* @author	Hervé GOUCHET [ contact(at)rvdevsign(dot)net ]
* @version	1.3.1
* @date		2009/03/17
* @doc		http://www.rvdevsign.net/ressources/javascript/jselect-plugin-jquery.html
* 
* Specifications :
* - HTML:
* <option value="0" selected="selected" class="my-class">Option One</option>
*
* - Array:
* [ [ "value", "text", "selected:bool", "class" ] ]
*
* - XML:
* <select>
*	<option value="0" text="Option One" selected="true" class="my-class" />
* </select>
*
* - JSON:
* { "select" : [ { "oValue": "0", "oText": "Option One", "oSelected": "true", "oClass": "my-class" } ] }
*
* Example:
* $('#load_select').jselect({
*	data: [ [ 0, "Option First" ], [ 1, "Option Second", true, "selected" ] ],
*	onChange: function(value, text){ isChange(value, text); },
*	loadUrl: "jselect.xml",
*	addOption: true,
*	addOptionUrl: "new-option.php"
* });
*/
(function($){
		   
	$.fn.jselect = function(settings){
		var jElements			= this;
		var settings			= $.extend({}, $.fn.jselect.defaults, settings);
		var data				= [];
		
		// Load data to construct Select
		if(settings.loadUrl){
			$.ajax({
				type: settings.loadType,
				url: settings.loadUrl,
				data: settings.loadData,
				dataType: settings.loadDataType,
				success: function(msg){
					var is_load	= false;
					if(msg){ is_load = true; }
					if(settings.data.length > 0){ parseData(settings.data, settings.dataType, !is_load, false); }
					if(is_load == true){ parseData(msg, settings.loadDataType, is_load, false); }
				},
				error: function(){
					settings.loadUrl = null;
					// Function called if an error occured when loading data
					if($.isFunction(settings.loadOnError)){ settings.loadOnError(); }
				}
			});
		}else if(settings.data.length > 0){
			parseData(settings.data, settings.dataType, true, false);
		}else{
			jselect();	
		}
		
		// Manage Select by load, add, reload data
		function jselect(){
			return jElements.each(function(){
				if(jElements.is("select") == true){
					// Generate Select with data[]
					manageSelect( $(jElements) );
					// Function called when process is completed
					if($.isFunction(settings.onComplete)){ settings.onComplete($(jElements)); }
				}
			});
		}
		
		// Parse data
		function parseData(pData, pDataType, pCreate, pGet){
			var properties		= { oValue: "", oText: "", oSelected: "", oClass: "" };
			var gData			= [];
				
			if(pDataType == 'xml' || pDataType == 'html'){
				$('option', pData).each( function() {
					oValue		= $(this).attr('value');
					oText		= (pDataType == 'xml' ? $(this).attr('text') : $(this).text());
					oSelected	= ($(this).attr('selected') == "true" || $(this).attr('selected') == "selected" ? true : false);
					if(oValue !== "" && oText !== ""){
						var option		= { oValue: oValue, oText: oText, oSelected: oSelected, oClass: $(this).attr('class') };
						option			= $.extend({}, properties, option);
						if(pGet == false){ data.push(option); } else{ gData.push(option); }
					}
				});
			}else if(pDataType == 'array'){
				var lenData		= pData.length;
				for(var i = 0; i < lenData; i++){
					if(pData[i].constructor.toString().indexOf("Array") == -1){
						if(pData[i] !== ""){
							var option	= { oValue: pData[i], oText: pData[i], oSelected: false, oClass: "" };
							option		= $.extend({}, properties, option);
							if(pGet == false){ data.push(option); } else{ gData.push(option); }
						}
					}else if(pData[i].length > 1){
						if(pData[i][0] !== "" && pData[i][1] !== ""){
							var option	= { oValue: pData[i][0], oText: pData[i][1], oSelected: (typeof pData[i][2] != "undefined" ? pData[i][2] : false), oClass: (typeof pData[i][3] != "undefined" ? pData[i][3] : "") };
							option		= $.extend({}, properties, option);
							if(pGet == false){ data.push(option); } else{ gData.push(option); }
						}
					}
				}
			}else if(pDataType == 'json'){
				var lenData		= pData.select.length;
				for(var i = 0; i < lenData; i++){
					if(pData.select[i].oValue !== "" && pData.select[i].oText !== ""){
						var option		= $.extend({}, properties, pData.select[i]);
						if(pGet == false){ data.push(option); } else{ gData.push(option); }
					}
				}
			}
			// Contruct Select
			if(pCreate == true && pGet == false){ jselect(); }
			// Get data parsed
			if(pGet == true){ return gData; }
			
		}
		
		// Manage all Select with loading datas
		function manageSelect(jSelect){
			// Manage Data
			var oData			= data;
			// Parse Select if replace Options in place is disabled
			if(settings.replaceAll == false){ 
				var gData		= parseData(jSelect, "html", false, true);
				oData			= gData.concat(oData);
			}
			// Free zone...
			jSelect.empty();
			// Manage Add Option in Select
			if(settings.addOption == true){ oData.push({ oValue: settings.addOptionValue, oText: settings.addOptionText, oSelected: false, oClass: settings.addOptionClass }); }
			// Generate Options in Select
			manageOption(jSelect, oData);
			// Change actions
			jSelect.change(function(){
				// Manage add option in select
				if(settings.addOption == true){ getOption(jSelect); }
				// Function called when Select is changed
				if($.isFunction(settings.onChange)){ settings.onChange($(this).val(), $(this).find("option[value='" + $(this).val() + "']").html(), $(this)); }
			});
		}
		
		// Create all Options in Select
		function manageOption(jSelect, oData){
			var dSelect			= jSelect.get(0);
			var lenData			= oData.length;
			
			// Init Select size
			dSelect.options.length		= lenData;
			// Create Option
			for(var o = 0; o < lenData; o++){
				createOption(dSelect, o, oData[o]);
			}
		}
		
		// Create an Option
		function createOption(dSelect, posOption, objOption){
			dSelect.options[posOption]	= new Option(objOption.oText, objOption.oValue);
			// Is selected ?
			if(objOption.oSelected && objOption.oSelected == true){ dSelect.options[posOption].selected = true; }
			// Has class ?
			if(objOption.oClass){ dSelect.options[posOption].setAttribute("class", objOption.oClass); }
		}
		
		// Get Option to add in Select
		function getOption(jSelect){
			if(jSelect.val() == settings.addOptionValue){
				var textOption	= prompt(settings.addOptionPrompt, "");
				if(textOption && settings.addOptionUrl){
					newOption(jSelect, textOption);
				}
			}
		}
		
		// Get value of the new Option
		function newOption(jSelect, textOption){
			$.ajax({
				type: settings.addOptionType,
				url: settings.addOptionUrl,
				data: settings.addOptionData + textOption,
				success: function(valueOption){
					if(valueOption && valueOption != ""){
						addOption(jSelect, valueOption, textOption);
					}else{
						// Report error on Add option				
						errorOption(jSelect, textOption);	
					}
				},error: function(){
					// Report error on Add option				
					errorOption(jSelect, textOption);
				}
			});
		}
		
		// Report error on Add option
		function errorOption(jSelect, textOption){
			// Disable Add Option
			settings.addOptionUrl		= null;
			// Select by default the first Option
			jSelect.get(0)[0].selected	= true;
			// Function called if Option wanted had "0" or "" as value
			if($.isFunction(settings.addOptionOnError)){ settings.addOptionOnError(textOption, jSelect); }
		}
		
		// Add option in Select (before option "Add option")
		function addOption(jSelect, valueOption, textOption){
			// Free zone
			var oData			= [];
			// Get Options in place
			oData				= parseData(jSelect, "html", false, true);
			// Delete the last option is "Add Option" is running
			if(settings.addOption == true){ oData.pop(); }
			// Add the new Option
			oData.push({ oValue: valueOption, oText: textOption, oSelected: settings.addOptionSetSelected, oClass: settings.addOptionSetClass });			
			// Manage Add Option in Select ?
			if(settings.addOption == true){ oData.push({ oValue: settings.addOptionValue, oText: settings.addOptionText, oSelected: false, oClass: settings.addOptionClass }); }
			// Generate Options in Select
			manageOption(jSelect, oData);
			// Call when adding is completed
			if($.isFunction(settings.addOptionOnComplete)){ settings.addOptionOnComplete(valueOption, textOption, jSelect); }
		}
	};

	// Default settings (dataType : xml, array, json or html)
	$.fn.jselect.defaults = {
		data: [],														// Array that contains all elements to create the new Option and Options by default
		dataType: "array",												// Defined default data type (xml, array, json and html)
		replaceAll: true,												// Replace content of the content before adding new data
		onChange: function(){},											// Function called on change of Select (return : value and text of selected Option and current jSelect element)
		onComplete: function(){},										// Function called when the process is done (return: jElement)
		loadUrl: null,													// URL called to load XML, Array, HTML or JSON data
		loadData: null,													// Params to complete URL to load
		loadType: "POST",												// Defined loading type (POST or GET)
		loadOnError: function(){},										// Function called if an error occured when loading data
		loadDataType: "xml",											// Defined loading data type (xml, array, json and html)
		addOption: false,												// Set action to add option by prompt
		addOptionUrl: null,												// URL called to save Option added in Select
		addOptionData: "newOption=",									// Params that contents text of the new option
		addOptionType: "POST",											// Defined sending type (POST or GET)
		addOptionValue: "-1",											// Value of Option "Add an option"
		addOptionText: "Add an option",									// Text of Option "Add an option"
		addOptionClass: null,											// Class of Option "Add an option"
		addOptionPrompt: "Text of the new option:",						// Text of the prompt "Add an option"
		addOptionSetSelected: true,										// The new Option must be selected after adding
		addOptionSetClass: null,										// Class of the new Option adding
		addOptiononComplete: function(){},								// Function called when adding option is done  (return : new id and text wanted for Option and current jSelect element)
		addOptionOnError: function(){}									// Function called if Option wanted has ""(empty) as value (return : text wanted for Option and current jSelect element)
	};
})(jQuery);
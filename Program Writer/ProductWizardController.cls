public with sharing class ProductWizardController {

    public Application__c app {get; set;}
    public Static String productStr {get; set;}
    public String pageMessage {get; set;}
    public Boolean displayMessage {get; set;}
    public String redirectUrl {get; set;}

    public ProductWizardController(ApexPages.StandardController controller) {
        app = ((Application__c) controller.getRecord());
        redirectUrl = controller.view().getUrl();

        // Get all available products to display on page
        List<Product__c> products = [SELECT Id, Name, Product_Name__c, Website_Category__c FROM Product__c 
                                    WHERE Include_in_Programs__c = true ORDER BY Product_Name__c ASC];
        productStr = '[';
        if (products.size() > 0) {
            for (Product__c prod : products) {
                productStr += '[" <input onclick=\'rowSelect(this);\' type=\'checkbox\' id=\'' + prod.Id + '\'/><i style=\'display:none;\'>' + prod.Website_Category__c + '</i>","' + prod.Product_Name__c + '"],';
            }
        }
        productStr += ']';

        // Page message to display any error/success messages to user
        pageMessage = '';
        displayMessage = false;
    }

    /*
    ** @description: This function handles parsing and saving the user selected products
    */
    public void addProducts() {
        // Parse the JSON param passed from VF page
        String addedProducts = Apexpages.currentPage().getParameters().get('addedProducts');
        ProductsJson parsedProducts = (ProductsJson)JSON.Deserialize(addedProducts, ProductsJson.class);
        displayMessage = true;

        // Create a list of application products from parsed JSON string
        List<Application_Product__c> productsToSave = new List<Application_Product__c>();
        for (ProductDetails product : parsedProducts.products) {
            Application_Product__c newProduct = new Application_Product__c();
            newProduct.Application__c = app.id;
            newProduct.Product__c = product.id;
            // Throw an error message if the values entered are not valid
            if ((( product.lbs != null && product.lbs != '' ) && !isDecimal(product.lbs) ) || (( product.oz != null && product.oz != '' ) && !isDecimal(product.oz))) {
                pageMessage = 'Please make sure that the entered values do not have any character(s).';
                return;
            }
            newProduct.LBS_ACRE__c = ( product.lbs == null || product.lbs == '' ) ? null : Decimal.valueof(product.lbs);
            newProduct.OZ_M__c = ( product.oz == null || product.oz == '' ) ? null : Decimal.valueof(product.oz);
            newProduct.Note__c = ( product.note == null || product.note == '' ) ? null : product.note;
            newProduct.Note_Other__c = ( product.noteother == null || product.noteother == '' ) ? null : product.noteother;
            productsToSave.add(newProduct);
        }

        // Insert application products
        try {
            insert productsToSave;
            pageMessage = 'Products have been added successfully! Please close this window.';
        } catch(Exception e) {
            System.Debug('******** Exception occurred in addProducts method: ' + e.getMessage());
            pageMessage = 'Oops! Something went wrong. Please check your debug logs.';
        }
    }

    public List<String> getNotePickListValues(){
        List<String> pickListValuesList= new List<String>();
        Schema.DescribeFieldResult fieldResult = Application_Product__c.Note__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            pickListValuesList.add(pickListVal.getValue() + ':' + pickListVal.getLabel());
        }
        return pickListValuesList;
    }

    private Boolean isDecimal(String check){
        try{
            Decimal.valueOf(check);
            return true; 
        } catch (Exception e) {
            return false;
        }
    }

    // Inner classes for deserialization
    private class ProductsJson {
        private List<ProductDetails> products {get; set;}
    }

    private class ProductDetails {
        private String id {get; set;}
        private String lbs {get; set;}
        private String oz {get; set;}
        private String note {get; set;}
        private String noteother {get; set;}
    }
}
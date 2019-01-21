List <


List <account> a = [select id, name, account_rank__c, Current_Year_FY_Sales__c from account 
                    where Current_Year_FY_Sales__c>0 order by Current_Year_FY_Sales__c desc ];

system.debug(a);
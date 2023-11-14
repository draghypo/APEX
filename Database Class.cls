/*												Database Class
											-----------------------
	
	Database Class:-  for creating and manipulating data. it contains some methods.
		ex:- Database.insert();
				Database.SaveResult[] results = Database.insert(listOfRecord, false); 
			 Database.update();
				Database.SaveResult[] results = Database.update(listOfRecord, false); 
			 Database.upsert();
				Database.UpsertResult[] results = Database.upsert(listOfRecord, false); 
			 Database.delete();
				Database.DeleteResult[] results = Database.delete(listOfRecord, false); 
			 Database.countQuery();- it will count the records.
			 etc.
		Que:- Already we have normal dml statement insert, update, delete etc.but why we use this Database class
				methods.
		Ans:- because of if we want to insert record in bulk amount and let suppose if one will be failed,
			  so all the record will be not commited. to achieve that we use Database.insert. 
			Syntax:- Database.insert(listRecord,false):- it will insert all the recored except those record which
					 has exception or anything.
					 Database.insert(listRecord, true):- it will work as same dml insert operation if one failed
					 all will be not inserted.
*/
public class DatabaseClass {
    // NORMAL DML OPERATION TO INSERT 
    public static void createAccountThroughDML() {
        List<Account> account = new List<Account>{
            new Account(Name = 'Munnan'),
            new Account(Name = 'Sadiq',phone='1234567890'),
            new Account(Phone = '098754321')
        };
            insert account; 
    }
    // THROUGH DATABASE.INSERT METHOD TO INSERT
    public static void createAccountThroughDatabaseClass() {
        List<Account> account = new List<Account>{
            new Account(Name = 'Munnan'),
            new Account(Name = 'Sadiq',phone='1234567890'),
            new Account(Phone = '098754321')
        };
           Database.SaveResult[] results = Database.insert(account, false); 
        for(Database.SaveResult result: results) {
            if(result.isSuccess()) {
                System.debug('record created successfully='+result.getId());
            }
            else {
                for(Database.Error error :result.getErrors()) {
                    System.debug('record failed due to '+error.getMessage()+'reason'); 
                    System.debug('statuscode='+error.getStatusCode());
                    System.debug('field occur='+error.getFields());
                }
            }
        }
    }
    //	COUNT THE RECORD OF OBJECT
    public static void countRecord(String objectApiName) {
        String QueryString = 'SELECT count() FROM '+objectApiName;
        Integer i = Database.countQuery(QueryString);
		System.debug('total account='+i);
    }
    
}

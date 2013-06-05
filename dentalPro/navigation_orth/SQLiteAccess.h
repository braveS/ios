
#define SELECT_EXPENSE_RANGES @"SELECT range_id,name,value FROM expense_ranges order by position"
#define SELECT_EXPENSE_TYPES  @"SELECT type_id,name FROM expense_types order by position"

#define SELECT_SETTINGS		  @"SELECT user_info.%@ FROM user_info"
#define UPDATE_SETTINGS		  @"UPDATE user_info SET %@ = ('%i')"

#define SELECT_CURRENT_COUNTRY @"SELECT current_country_code FROM user_info"
#define SELECT_SHOW_TIPS	   @"SELECT show_tips FROM user_info"
#define INSERT_OR_REPLACE_COUNTRY  @"INSERT OR REPLACE INTO user_info (current_country_code) VALUES ('%@')"
#define INSERT_COUNTRY		   @"INSERT INTO user_info (current_country_code) VALUES ('%@')"
#define UPDATE_COUNTRY		   @"UPDATE user_info SET current_country_code = ('%@')"
#define SELECT_COUNTRY_INFO	   @"SELECT countries.country_code, countries.country_name,countries.currency, apr_table.good_apr as good_apr, apr_table.bad_apr as bad_apr, apr_table.low_apr as low_apr FROM countries JOIN apr_table ON apr_table.country_code = countries.country_code WHERE countries.country_code = ('%@')"
#define SELECT_COUNTRY_CODES   @"SELECT country_code FROM countries order by country_code"
#define SELECT_COUNTRY_LIST	   @"SELECT country_code, country_name FROM countries order by country_code"
#define SELECT_TEXT			   @"SELECT text FROM app_text WHERE definition = ('recommend')"

#define SELECT_TYPES          @"SELECT type_id, name FROM types ORDER BY position ASC"
#define SELECT_SPECS          @"SELECT specialization_id, name FROM specializations ORDER BY position ASC"
#define SELECT_QUESTIONS	  @"SELECT question_id, number, questionText FROM questions ORDER BY number"

#define SELECT_ANSWER		  @"SELECT text FROM answer"
#define DELETE_ANSWER		  @"DELETE FROM answer"
#define INSERT_ANSWER		  @"INSERT INTO answer (text) VALUES ('%@')"

#define SELECT_ALL_TOTAL_EARNINGS @"SELECT SUM(t_earnings + nt_earnings) as total_earnings FROM txn"
#define SELECT_TOTAL_EARNINGS_LAST @"SELECT SUM(t_earnings + nt_earnings) as total_earnings FROM txn WHERE _id < (select max(_id) from txn)"

#define INSERT_TXN			  @"INSERT INTO txn (card_id,date,expense_type_id,t_earnings,nt_earnings) VALUES (%i,date('now'),%i,%f,%f)"
#define SELECT_EARNINGS		  @"select sum(t_earnings + nt_earnings) from txn where date > date('now', '-%i day')"

#define SELECT_CARDS_BILLING_CYCLE @"SELECT card_id, card_name, billing_cycle, specialization_id FROM cards ORDER BY billing_cycle"

#define INSERT_CARD			  @"INSERT INTO cards (card_name, billing_cycle, type_id, specialization_id) VALUES ('%@', '%i', '%i', '%i')"
#define	UPDATE_CARD			  @"update cards set card_name = ('%@'), billing_cycle = ('%i'), type_id = ('%i'), specialization_id = ('%i')  where card_id = ('%i')" 
#define UPDATE_PAYMENT		  @"update cards set payment_date = ('%@'), payment_type = ('%i') where card_id = ('%i')" 
#define DELETE_CARD			  @"DELETE FROM cards WHERE card_id = %i"
#define DELETE_TXN_CARD		  @"DELETE FROM txn where card_id = %i"
#define SELECT_CARDS          @"SELECT card_id, card_name, billing_cycle, type_id, payment_date, payment_type, cards.specialization_id, specializations.name as  specialization_name FROM cards join specializations on specializations.specialization_id=cards.specialization_id order by card_id"																																										
#define SELECT_CARD			  @"SELECT card_id, card_name, billing_cycle, type_id, cards.specialization_id, specializations.name as  specialization_name FROM cards join specializations on specializations.specialization_id=cards.specialization_id WHERE card_id = (%i)"

#define SELECT_MONTH		  @"select strftime('%%Y%%m',date('now','start of month','%i month'))"
#define SELECT_MONTH_EARN	  @"select sum(t_earnings + nt_earnings) from txn where date >=date('now','start of month','%i month') and date <= date('now','%i month')"

#define SELECT_DAY				  @"select strftime('%%d%%m',date('now','%i day'))"
#define SELECT_THREE_DAYS_EARN	  @"select sum(t_earnings + nt_earnings) from txn where date >= date('now','%i day') and date <= date('now','%i day')"

#define SELECT_TVELFE_TRANS	  @"select sum(t_earnings + nt_earnings) from (select * from txn ORDER BY _id DESC LIMIT %i, 1)"


#define UPDATE_TXN_PARTIAL    @"update  txn set t_earnings = -t_earnings  where card_id=%i and date <=date('%@', '-%i month') and date >= date('%@', '-%i month')"
#define UPDATE_TXN_MIN        @"update  txn set t_earnings = 0 where card_id=%i and date <=date('%@', '-%i month') and date >= date('%@', '-%i month')"

@interface SQLiteAccess : NSObject {

    NSNumber *lastInsertRowId;

}
		
@property (assign, nonatomic) NSNumber *lastInsertRowId;
+ (NSString *)selectOneValueSQL:(NSString *)sql;
+ (NSArray *)selectManyValuesWithSQL:(NSString *)sql;

+ (id)selectOneRowWithSQL:(NSString *)sql model:(Class)modelClass;
+ (NSArray *)selectManyRowsWithSQL:(NSString *)sql model:(Class)modelClass;

+ (NSNumber *)insertWithSQL:(NSString *)sql;
+ (void)updateWithSQL:(NSString *)sql;
+ (void)deleteWithSQL:(NSString *)sql;

@end
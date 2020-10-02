<flow name="dw_arrays" doc:id="0df68a94-4296-4589-bb7a-713cab7d9e0a" >
		<ee:transform doc:name="Transform Message" doc:id="42ba7822-ac47-4465-aaf4-07116e522934" >
			<ee:message >
				<ee:set-payload ><![CDATA[%dw 2.0
output application/json
import * from dw::core::Arrays

var arr=[1,2,3,4,5,6]
var names=['mahesh','ankur','ayush','komal','nidhi','kiyansh']
var users = [
	{name: "mahesh", lastName: "sharma"}, 
	{name: "ankur", lastName: "parashar"}, 
	{name: "ayush", lastName: "parashar"}
]
var customers = 
[	{id: "1", name:"Mahesh"},
	{id: "2", name:"Ankur"},
	{id: "3", name:"Ayush"},
	{id: "5", name:"Kiyansh"}
]
var products = 
[
	{ownerId: "1", name:"Physics"},
	{ownerId: "1", name:"Maths"}, 
	{ownerId: "3", name:"Commerce"}, 
	{ownerId: "4", name:"RocketScience"}
]
var arr0 = [] as Array<Number>
---
{
	countBy: arr countBy(($ mod 2)==0),
	divideBy2: arr divideBy 2,
	divideBy3: arr divideBy 3,
	divideBy4: arr divideBy 4,
	
	drop: names drop 2,
	//The Objects module has a new function that iterates over 
	//and ignores the items in an array until the specified condition is true.
	dropwhile: arr dropWhile $ < 4,
	
	take: names take 2,
	//The Objects module has a new function that 
	//iterates over the items in an array items while a condition is true.
	takeWhile: arr takeWhile $ < 4,
	
	indexOf: names indexOf 'ankur',
	indexWhere: names indexWhere(item)-> 
				item startsWith 'ki',
				
	partition: arr partition (item) -> isEven(item),
	
	splitAt: names splitAt 1,
	splitWhere: names splitWhere (item) -> item startsWith "ay",
	
	slice: slice(arr, 1, 4),
	
	a: users firstWith ((user, index) -> user.name == "mahesh"),
    b: users firstWith ((user, index) -> user.lastName == "parashar"),
    
    //join returns an array all the left items, 
    //merged by ID with any right items that exist.
    join:  join(customers, products, (user) -> 
    	user.id, (product) -> product.ownerId),
    	
    //leftJoin returns an array all the left items, 
    //merged by ID with any right items that meet the joining criteria.	
    leftJoin: leftJoin(customers, products, (user) -> 
    	user.id, (product) -> product.ownerId),
    
    //outerJoin returns an array with all the left items, merged by ID with 
    //the right items in cases where any exist, 
    //and it returns right items that are not present in the left.
    outerJoin: outerJoin(customers, products, (user) -> 
    	user.id, (product) -> product.ownerId)
  }]]></ee:set-payload>
			</ee:message>
		</ee:transform>
		<ee:transform doc:name="some every" doc:id="c6228e7c-1261-4692-9a36-a1835a01c7de">
			<ee:message>
				<ee:set-payload><![CDATA[%dw 2.0
output application/json
import * from dw::core::Arrays

var arr0=[] as Array
---
/*
 * Returns true if every element in 
 * the array matches the condition.
 * The function stops iterating after the first negative evaluation 
 * of an element in the array.
 */
{"every":{ "results" : [
     "ok" : [
        [1,1,1] every ($ == 1),
        [1] every ($ == 1)
     ],
     "err" : [
        [1,2,3] every ((log('should stop at 2 ==', $) mod 2) == 1),
        [1,1,0] every ($ == 1),
        [0,1,1,0] every (log('should stop at 0 ==', $) == 1),
        [1,2,3] every ($ == 1),
        arr0 every true,
     ]
   ]
 },
 /*Returns true if at least one element 
  * in the array matches the specified condition.The function stops 
  * iterating after the first element that matches the condition 
  * is found.
  * 
  */
 "some":{
 	"results" : [
     "ok" : [
       [1,2,3] some (($ mod 2) == 0),
       [1,2,3] some ((nextNum) -> (nextNum mod 2) == 0),
       [1,2,3] some (($ mod 2) == 1),
       [1,2,3,4,5,6,7,8] some (log('should stop at 2 ==', $) == 2),
       [1,2,3] some ($ == 1),
       [1,1,1] some ($ == 1),
       [1] some ($ == 1)
     ],
     "err" : [
       [1,2,3] some ($ == 100),
       [1] some ($ == 2)
     ]
   ]
 }
 }]]></ee:set-payload>
			</ee:message>
		</ee:transform>
	</flow>

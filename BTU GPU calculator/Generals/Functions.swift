//
//  Functions.swift
//  BTU GPU calculator
//
//  Created by USER on 11.06.21.
//

import Foundation


var letters = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","w","z",
               "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
               "ა","ბ","გ","დ","ე","ვ","ზ","თ","ი","კ","ლ","მ","ნ","ო","პ","ჟ","რ","ს","ტ","უ","ფ","ქ","ღ","ყ","შ","ჩ","ც","ძ","წ","ჭ","ხ","ჯ"
               ,"ჰ","!","ძ","@","#","$","^","%","&","*","(",")","-","_","+","="] // used to determine if input has any letters in it

func containsALetter(string:String)->Bool{
    for letter in string{
        if(letters.contains(String(letter))){
            return true
        }
        else {return false}
    }
    return true
}

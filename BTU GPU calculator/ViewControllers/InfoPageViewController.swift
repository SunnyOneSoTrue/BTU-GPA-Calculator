//
//  InfoPageViewController.swift
//  BTU GPU calculator
//
//  Created by USER on 13.06.21.
//

import UIKit

class InfoPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var titles: [String] = ["საგნის GPA",
                          "სემესტრის GPA",
                          "წლიური GPA",
                          "სადიპლომო GPA"]
    var info: [String] = [
                        "ყველაფერი იწყება საგნის GPAებიდან. ყველა დანარჩენ გრაფაში აუცილებელია ჯერ საგნის GPAს შევსება და მერე შესაბამის გრაფაში ინფორმაციის დამატება.",
                          
                          "სემესტრში ყველა მიღებული „GPA“ მრავლდება კრედიტების რაოდენობაზე და მათი ჯამი იყოფა სემესტრში მისაღები კრედიტების რაოდენობაზე ΣCR=30 (ან სხვა, რამდენზეც იყო დარეგისტრირებული სტუდენტი). რომ დავთავლოთ სემესტრის GPA, უნდა საგნის GPAში ჩავწეროთ სემესტში განვლილი საგნები, ხოლო სემესტრის GPAში - აღებული კრედიტები დავუმატოთ",
                          
                          " აკადემიურ წელს ყველა მიღებული „GPA“ მრავლდება კრედიტების რაოდენობაზე და მათი ჯამი იყოფა აკადემიური წლის განმავლობაში მისაღები კრედიტების რაოდენობაზე (რამდენზეც იყო დარეგისტრირებული სტუდენტი). წლიური GPA რომ დავთვალოთ, მაშინ აკადემიურ წელიწადში გავლილი ყველა საგანი უნდა შევიყვანოთ სემესტრის GPAში, ხოლო წლიურ GPAში მივუთითოთ წელიწადში ასაღები კრედიტების ჯამი.",
                          
                          " პროგრამის GPA(p). პროგრამით სწავლის პერიოდში ყველა მიღებული „GPA“ მრავლდება კრედიტების რაოდენობაზე და მათი ჯამი იყოფა პროგრამის კრედიტების რაოდენობაზე: GPA(p)= Σ(GPA x CR) / ΣCR. დიპლომის GPA უდრის პროგრამის GPA-ს. თუ სტუდენტს არ აქვს მიღებული პროგრამისთვის დადგენილი კრედიტების რაოდენობა, მაშინ პროგრამის GPA =0. სადიპლომო GPA არის ის, რასაც სერთიფიკატებზე დაგვიწერენ. რომ დავთვალოთ იგი აუცილებელია ჩავწეროთ ყველა წელს ყველა საგანში აღებული ქულის, კრედიტის და ასევე ასაღები კრედიტის დარეგისტრირება."]
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell") as! InfoTableViewCell
        cell.titleLabel.text = titles[indexPath.row]
        cell.infoLabel.text = info[indexPath.row]
        return cell
    }

}

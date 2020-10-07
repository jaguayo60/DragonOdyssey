//
//  SharedDataExtensions.swift
//  DragonOdyssey
//
//  Created by Jared on 10/6/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit

class SharedExtensions: NSObject {

}

extension Int32
{
    func toInt() -> Int
    {
        return Int(self)
    }
    
    func toFloat() -> Float
    {
        return Float(self)
    }
    
    func toCGFloat() -> CGFloat
    {
        return CGFloat(self)
    }
    
    func toNSNumber() -> NSNumber
    {
        return self as NSNumber
    }
}

extension Int
{
    func toInt32() -> Int32
    {
        return Int32(self)
    }
    
    func toUInt32() -> UInt32
    {
        return UInt32(self)
    }
    
    func toNSNumber() -> NSNumber
    {
        return self as NSNumber
    }
    
    func toFloat() -> Float
    {
        return Float(self)
    }
    
    func toCGFloat() -> CGFloat
    {
        return CGFloat(self)
    }
    
    func toString() -> String
    {
        return String(self)
    }
    
    func roundedToNearest(interval: Int) -> Int
    {
        return interval * Int(round(Float(self) / Float(interval)))
    }
    
    var roundedWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            if Decimal(round(million*10)/10).isWholeNumber { return "\(Int(round(million*10)/10))M" }
            return "\(round(million*10)/10)M"
        }
        else if thousand >= 1.0 {
            if Decimal(round(thousand*10)/10).isWholeNumber { return "\(Int(round(thousand*10)/10))K" }
            return "\(round(thousand*10)/10)K"
        }
        else {
            return "\(Int(number))"
        }
    }
    
    func square() -> Int
    {
        return self * self
    }
}

extension Decimal
{
    var isWholeNumber: Bool {
        if isZero { return true }
        if !isNormal { return false }
        var myself = self
        var rounded = Decimal()
        NSDecimalRound(&rounded, &myself, 0, .plain)
        return self == rounded
    }
}

extension Float
{
    func toInt() -> Int
    {
        return Int(self)
    }
    
    func toCGFloat() -> CGFloat
    {
        return CGFloat(self)
    }
    
    func toNSNumber() -> NSNumber
    {
        return self as NSNumber
    }
    
    func rounded(toPlaces places:Int) -> Float
    {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}

extension CGFloat
{
    func toInt() -> Int
    {
        return Int(self)
    }
    
    func toFloat() -> Float
    {
        return Float(self)
    }
    
    func roundTo(nearest: CGFloat) -> CGFloat
    {
        let n = 1/nearest
        let numberToRound = self * n
        return numberToRound.rounded() / n
    }
    
    //    func roundUp(value: Double) -> Int {
    //        if value == Double(Int(value)) {
    //            return Int(value)
    //        } else if value < 0 {
    //            return Int(value)
    //        } else {
    //            return Int(value) + 1
    //        }
    //    }
    
    func roundUp() -> Int
    {
        if self == CGFloat(Int(self))
        {
            return Int(self)
        }
            
        else if self < 0
        {
            return Int(self)
        }
            
        else
        {
            return Int(self) + 1
        }
    }
}

extension Double
{
    func toNSNumber() -> NSNumber
    {
        return self as NSNumber
    }
    
    func rounded(toPlaces places:Int) -> Double
    {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    var cleanString: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

extension NSNumber
{
    func toInt32() -> Int32?
    {
        if let intValue = self as? Int32
        {
            return intValue
        }
        else { return nil }
    }
    
    func toInt() -> Int?
    {
        if let intValue = self as? Int
        {
            return intValue
        }
        else { return nil }
    }
    
    func toString() -> String
    {
        return String(describing: self)
    }
    
    func toDouble() -> Double
    {
        return Double(truncating: self)
    }
    
    func toFloat() -> Float?
    {
        if let floatValue = self as? Float
        {
            return floatValue
        }
        else { return nil }
    }
    
    func toCGFloat() -> CGFloat?
    {
        if let floatValue = self as? CGFloat
        {
            return floatValue
        }
        else { return nil }
    }
    
    func toBool() -> Bool?
    {
        switch self
        {
        case 1:
            return true
        case 0:
            return false
        default:
            return nil
        }
    }
}

extension Bool
{
    func toNSNumber() -> NSNumber
    {
        if self == true
        {
            return 1
        }
        else
        {
            return 0
        }
    }
    
    func toYesNoString() -> String
    {
        if self == true
        {
            return "Yes"
        }
        else
        {
            return "No"
        }
    }
}

extension Array
{
    mutating func remove(indexes: [Int])
    {
        var lastIndex: Int? = nil
        for index in indexes.sorted(by: >) {
            guard lastIndex != index else {
                continue
            }
            remove(at: index)
            lastIndex = index
        }
    }
}

extension Data
{
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

extension String
{
    func toBool() -> Bool?
    {
        switch self
        {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
    
    func toInt() -> Int?
    {
        return Int(self)
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    var containsWhitespace : Bool {
        return(self.rangeOfCharacter(from: .whitespacesAndNewlines) != nil)
    }
    
    func toDate_yyyyMMdd() -> Date?
    {
        let df = DateFormatter()
        df.dateFormat = "yyyyMMdd"
        
        if let date = df.date(from: self)
        {
            return date
        }
        else { return nil }
    }

    func toDateWithFormat(formatString: String) -> Date?
    {
        let df = DateFormatter()
        df.dateFormat = formatString
        
        if let date = df.date(from: self)
        {
            return date
        }
        else { return nil }
    }
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript(_ range: CountableRange<Int>) -> String
    {
        let idx1 = index(startIndex, offsetBy: max(0, range.lowerBound))
        let idx2 = index(startIndex, offsetBy: min(self.count, range.upperBound))
        return String(self[idx1..<idx2])
    }
    /* example
     let s = "hello"
     s[0..<3] // "hel"
     s[3..<s.count] // "lo"
     */
    
    func firstLetters(numberOfLetters: Int) -> String
    {
        return String(self.prefix(numberOfLetters))
    }
    
    func removeCharactersAtStart(numberOfCharacters:Int) -> String
    {
        return String(self.dropFirst(numberOfCharacters))
    }
    
    func removeCharactersAtEnd(numberOfCharacters:Int) -> String
    {
        return String(self.dropLast(numberOfCharacters))
    }
    
    func slice(from: String, to: String) -> String? {
        
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
    
    func arrayOfSubStringsMatching(regexPattern: String) -> [String]?
    {
        var regex: NSRegularExpression
        
        do {
            regex = try NSRegularExpression(pattern: regexPattern, options: [])
        } catch {
            return nil
        }
        
        let results = regex.matches(in: self, options: [], range: NSRange(location:0, length: self.count))
        
        var subStrings = [String]()
        let nsString = self as NSString
        
        for result in results
        {
            let subString = nsString.substring(with: result.range)
            if subString != "" { subStrings.append(subString) }
        }
        
        if subStrings.count > 0 { return subStrings }
        else { return nil }
    }
    
    func numberOfOccurrencesOf(string: String) -> Int {
        return self.components(separatedBy:string).count - 1
    }
    
    func numberOfLines() -> Int {
        return self.numberOfOccurrencesOf(string: "\n") + 1
    }
    
    // MARK: - HTML Formatting
    
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
    func removeHTMLTag(tag:String) -> String {
        return self.replacingOccurrences(of: "(?i)</?\(tag)\\b[^<]*>", with: "", options: .regularExpression, range: nil)
    }
    
    func removeHTMLTags(tags:[String]) -> String {
        var mutableString = self
        for tag in tags {
            mutableString = mutableString.removeHTMLTag(tag: tag)
        }
        return mutableString
    }
    
    var html2Attributed: NSAttributedString? {
        do {
            guard let data = data(using: String.Encoding.utf8) else {
                return nil
            }
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    
    var htmlAttributed: (NSAttributedString?, NSDictionary?) {
        do {
            guard let data = data(using: String.Encoding.utf8) else {
                return (nil, nil)
            }
            
            var dict:NSDictionary?
            dict = NSMutableDictionary()
            
            return try (NSAttributedString(data: data,
                                           options: [.documentType: NSAttributedString.DocumentType.html,
                                                     .characterEncoding: String.Encoding.utf8.rawValue],
                                           documentAttributes: &dict), dict)
        } catch {
            print("error: ", error)
            return (nil, nil)
        }
    }
    
    func htmlAttributed(using font: UIFont, color: UIColor) -> NSAttributedString? {
        do {
            let htmlCSSString = "<style>" +
                "html *" +
                "{" +
                "font-size: \(font.pointSize)pt !important;" +
                "color: #\(color.hexString!) !important;" +
                "font-family: \(font.familyName), Helvetica !important;" +
            "}</style> \(self)"
            
            guard let data = htmlCSSString.data(using: String.Encoding.utf8) else {
                return nil
            }
            
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    
    func htmlAttributed(family: String?, size: CGFloat, color: UIColor) -> NSAttributedString?
    {
        do {
            let htmlCSSString = "<style>" +
                "html *" +
                "{" +
                "font-size: \(size)pt !important;" +
                "color: #\(color.hexString!) !important;" +
                "font-family: \(family ?? "Helvetica"), Helvetica !important;" +
            "}</style> \(self)"
            
            guard let data = htmlCSSString.data(using: String.Encoding.utf8) else
            {
                return nil
            }
            
//            return try NSAttributedString(data: data,
//                                          options: [.documentType: NSAttributedString.DocumentType.html,
//                                                    .characterEncoding: String.Encoding.utf8.rawValue],
//                                          documentAttributes: nil)
            
            let initialAttributedString = try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)

            let mutableAttributedString = NSMutableAttributedString(attributedString: initialAttributedString)

            let range = NSRange(location: 0, length: mutableAttributedString.length)
            if let paragraphStyle = mutableAttributedString.attribute(NSAttributedString.Key.paragraphStyle, at: 0, effectiveRange: nil) as? NSMutableParagraphStyle
            {
                paragraphStyle.paragraphSpacing = 0
                paragraphStyle.alignment = .left

                mutableAttributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
            }

            return mutableAttributedString
            
        } catch {
            print("error: ", error)
            return nil
        }
    }
}

extension NSMutableAttributedString
{
    func setAsLink(textToFind:String, linkURL:String) -> Bool
    {
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.addAttribute(.link, value: linkURL, range: foundRange)
            return true
        }
        return false
    }
    
    func apply(attributes:[NSAttributedString.Key : Any], toPhrase phrase:String)
    {
        let phraseRange = self.mutableString.range(of: phrase)
        if phraseRange.location != NSNotFound {
            self.addAttributes(attributes, range: phraseRange)
        }
    }
}

extension Calendar {
    static let gregorian = Calendar(identifier: .gregorian)
}

extension Date
{
    // MARK: - time of day
    
    func withSetHour(hour:Int) -> Date
    {
        return Calendar.current.date(bySettingHour: hour, minute: 0, second: 0, of: self)!
    }
    
    func withSetHour(hour:Int, andMinute minute:Int) -> Date
    {
        return Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: self)!
    }
    
    func setToClosetHour() -> Date
    {
        let component = Calendar.gregorian.dateComponents([.hour], from: self)
        return self.withSetHour(hour: component.hour!)
    }
    
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    var midnight: Date {
        return Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: self)!
    }
    
    func withTimeOf(date: Date) -> Date
    {
        let calendar = Calendar.gregorian
        
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: self)
        let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: date)
        
        var mergedComponments = DateComponents()
        mergedComponments.year = dateComponents.year!
        mergedComponments.month = dateComponents.month!
        mergedComponments.day = dateComponents.day!
        mergedComponments.hour = timeComponents.hour!
        mergedComponments.minute = timeComponents.minute!
        mergedComponments.second = timeComponents.second!
        
        return calendar.date(from: mergedComponments)!
    }
    
    func hasSameTimeAs(date: Date) -> Bool
    {
        let calendar = Calendar.gregorian
        let sameHour = calendar.isDate(self, equalTo: date, toGranularity: .hour)
        let sameMinute = calendar.isDate(self, equalTo: date, toGranularity: .minute)
        
        return (sameHour == true && sameMinute == true)
    }
    
    // MARK: - Day
    
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    
    var isToday: Bool {
        return self.toString_yyyyMMdd() == Date().toString_yyyyMMdd()
    }
    
    func isSameDayAs(date: Date) -> Bool {
        return self.toString_yyyyMMdd() == date.toString_yyyyMMdd()
    }
    
    func plusNumberOfDays(numberOfDays: Int) -> Date
    {
        return Calendar.current.date(byAdding: .day, value: numberOfDays, to: self)!
    }
    
    func numberOfDaysInBetweenSelfAndDate(date: Date) -> Int
    {
        let currentCalendar = Calendar.current
        let comp = Calendar.Component.day
        
        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }
        let num = end - start
        
        return (num < 0) ? -num : num
    }
    
    // MARK: - Week
    
    var startOfWeek: Date
    {
        let cal = Calendar(identifier: .gregorian)
        return cal.date(from: cal.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
    }
    
    var endOfWeek: Date
    {
        let gregorian = Calendar(identifier: .gregorian)
        let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
        return gregorian.date(byAdding: .day, value: 7, to: sunday!)!
    }
    
    var startOfNextWeek: Date
    {
        let gregorian = Calendar(identifier: .gregorian)
        let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
        return gregorian.date(byAdding: .day, value: 7, to: sunday!)!
    }
    
    func arrayOfDatesFromPastWeek() -> [Date]
    {
        return [
            self.plusNumberOfDays(numberOfDays: -6),
            self.plusNumberOfDays(numberOfDays: -5),
            self.plusNumberOfDays(numberOfDays: -4),
            self.plusNumberOfDays(numberOfDays: -3),
            self.plusNumberOfDays(numberOfDays: -2),
            self.plusNumberOfDays(numberOfDays: -1),
            self
        ]
    }
    
    // MARK: - Month
    
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return tomorrow.month != month
    }
    
    // MARK: - Strings
    
    func toString_yyyyMMdd() -> String
    {
        let df = DateFormatter()
        df.dateFormat = "yyyyMMdd"
        return df.string(from: self)
    }
    
    func toString_day3CharLowercased() -> String
    {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX") // ⚠️ w/o this, day of week will be in localized language
        df.dateFormat = "eee"
        let dayString = df.string(from: self)
        return dayString.lowercased()
    }
    
    func stringWithFormat(formatString: String) -> String
    {
        let format = DateFormatter.dateFormat(fromTemplate: formatString, options: 0, locale: NSLocale.current)
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
    
    func dayStringForTimezone_yyyyMMdd(timeZoneAbbreviation: String) -> String
    {
        let timeZone = TimeZone(abbreviation: timeZoneAbbreviation)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
//        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        dateFormatter.timeZone = timeZone
        
        return dateFormatter.string(from: self)
        
//        let convertedDateString = dateFormatter.string(from: Date())
//
//        return convertedDateString.toDateWithFormat(formatString:"E, d MMM yyyy HH:mm:ss Z")
        
        //        let targetOffset = TimeInterval(mdtTimeZone?.secondsFromGMT(for: self))
        
        //        let dateFormatter = DateFormatter()
        //        dateFormatter.dateFormat = "dd:MM:yyy hh:mm:ss"
        //
        //        let timeZone = TimeZone(identifier: "Europe/Amsterdam")
        //
        //        dateFormatter.timeZone = timeZone
        //
        //        dateFormatter.string(from: Date())
    }
    
    func stringForTimeZone(timeZoneAbbreviation: String, withFormat format: String) -> String
    {
        let timeZone = TimeZone(abbreviation: timeZoneAbbreviation)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = timeZone
        
        return dateFormatter.string(from: self)
    }
    
    // MARK: -
    
    // ⚠️ sketchy/buggy in iOS 10
//    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {
//
//        let currentCalendar = Calendar.current
//
//        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
//        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }
//
//        return end - start
//    }
    
    //    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    //    [df setDateFormat:@"HHmmss"];
    //    int dateInt = [[df stringFromDate:date]intValue];
    //    int anotherDateInt = [[df stringFromDate:anotherDate]intValue];
    //
    //    return (dateInt < anotherDateInt) ? YES : NO;
    
    func isPriorTo(date: Date) -> Bool
    {
        return self < date
    }
}

extension UIColor
{
    static func from (hexValue:String) -> UIColor
    {
        var cString:String = hexValue.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    var hexString:String? {
        if let components = self.cgColor.components {
            let r = components[0]
            let g = components[1]
            let b = components[2]
            return  String(format: "%02X%02X%02X", (Int)(r * 255), (Int)(g * 255), (Int)(b * 255))
        }
        return nil
    }
}

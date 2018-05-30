//
//  GRDuration.swift
//
//  Created by Mahendra on 29/05/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class GRDuration: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let text = "text"
    static let value = "value"
  }

  // MARK: Properties
  public var text: String?
  public var value: Int?

  // MARK: ObjectMapper Initializers
  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  public required init?(map: Map){

  }

  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  public func mapping(map: Map) {
    text <- map[SerializationKeys.text]
    value <- map[SerializationKeys.value]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = text { dictionary[SerializationKeys.text] = value }
    if let value = value { dictionary[SerializationKeys.value] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.text = aDecoder.decodeObject(forKey: SerializationKeys.text) as? String
    self.value = aDecoder.decodeObject(forKey: SerializationKeys.value) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(text, forKey: SerializationKeys.text)
    aCoder.encode(value, forKey: SerializationKeys.value)
  }

}

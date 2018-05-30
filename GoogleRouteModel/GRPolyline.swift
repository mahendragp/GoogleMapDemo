//
//  GRPolyline.swift
//
//  Created by Mahendra on 29/05/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class GRPolyline: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let points = "points"
  }

  // MARK: Properties
  public var points: String?

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
    points <- map[SerializationKeys.points]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = points { dictionary[SerializationKeys.points] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.points = aDecoder.decodeObject(forKey: SerializationKeys.points) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(points, forKey: SerializationKeys.points)
  }

}

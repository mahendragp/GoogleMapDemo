//
//  GREndLocation.swift
//
//  Created by Mahendra on 29/05/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class GREndLocation: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let lat = "lat"
    static let lng = "lng"
  }

  // MARK: Properties
  public var lat: Double?
  public var lng: Double?

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
    lat <- map[SerializationKeys.lat]
    lng <- map[SerializationKeys.lng]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = lat { dictionary[SerializationKeys.lat] = value }
    if let value = lng { dictionary[SerializationKeys.lng] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.lat = aDecoder.decodeObject(forKey: SerializationKeys.lat) as? Double
    self.lng = aDecoder.decodeObject(forKey: SerializationKeys.lng) as? Double
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(lat, forKey: SerializationKeys.lat)
    aCoder.encode(lng, forKey: SerializationKeys.lng)
  }

}

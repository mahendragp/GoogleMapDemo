//
//  GRGeocodedWaypoints.swift
//
//  Created by Mahendra on 29/05/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class GRGeocodedWaypoints: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let types = "types"
    static let geocoderStatus = "geocoder_status"
    static let placeId = "place_id"
  }

  // MARK: Properties
  public var types: [String]?
  public var geocoderStatus: String?
  public var placeId: String?

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
    types <- map[SerializationKeys.types]
    geocoderStatus <- map[SerializationKeys.geocoderStatus]
    placeId <- map[SerializationKeys.placeId]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = types { dictionary[SerializationKeys.types] = value }
    if let value = geocoderStatus { dictionary[SerializationKeys.geocoderStatus] = value }
    if let value = placeId { dictionary[SerializationKeys.placeId] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.types = aDecoder.decodeObject(forKey: SerializationKeys.types) as? [String]
    self.geocoderStatus = aDecoder.decodeObject(forKey: SerializationKeys.geocoderStatus) as? String
    self.placeId = aDecoder.decodeObject(forKey: SerializationKeys.placeId) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(types, forKey: SerializationKeys.types)
    aCoder.encode(geocoderStatus, forKey: SerializationKeys.geocoderStatus)
    aCoder.encode(placeId, forKey: SerializationKeys.placeId)
  }

}

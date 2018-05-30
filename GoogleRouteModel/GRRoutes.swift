//
//  GRRoutes.swift
//
//  Created by Mahendra on 29/05/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class GRRoutes: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let summary = "summary"
    static let legs = "legs"
    static let overviewPolyline = "overview_polyline"
    static let bounds = "bounds"
    static let waypointOrder = "waypoint_order"
    static let warnings = "warnings"
    static let copyrights = "copyrights"
  }

  // MARK: Properties
  public var summary: String?
  public var legs: [GRLegs]?
  public var overviewPolyline: GROverviewPolyline?
  public var bounds: GRBounds?
  public var waypointOrder: [Any]?
  public var warnings: [Any]?
  public var copyrights: String?

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
    summary <- map[SerializationKeys.summary]
    legs <- map[SerializationKeys.legs]
    overviewPolyline <- map[SerializationKeys.overviewPolyline]
    bounds <- map[SerializationKeys.bounds]
    waypointOrder <- map[SerializationKeys.waypointOrder]
    warnings <- map[SerializationKeys.warnings]
    copyrights <- map[SerializationKeys.copyrights]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = summary { dictionary[SerializationKeys.summary] = value }
    if let value = legs { dictionary[SerializationKeys.legs] = value.map { $0.dictionaryRepresentation() } }
    if let value = overviewPolyline { dictionary[SerializationKeys.overviewPolyline] = value.dictionaryRepresentation() }
    if let value = bounds { dictionary[SerializationKeys.bounds] = value.dictionaryRepresentation() }
    if let value = waypointOrder { dictionary[SerializationKeys.waypointOrder] = value }
    if let value = warnings { dictionary[SerializationKeys.warnings] = value }
    if let value = copyrights { dictionary[SerializationKeys.copyrights] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.summary = aDecoder.decodeObject(forKey: SerializationKeys.summary) as? String
    self.legs = aDecoder.decodeObject(forKey: SerializationKeys.legs) as? [GRLegs]
    self.overviewPolyline = aDecoder.decodeObject(forKey: SerializationKeys.overviewPolyline) as? GROverviewPolyline
    self.bounds = aDecoder.decodeObject(forKey: SerializationKeys.bounds) as? GRBounds
    self.waypointOrder = aDecoder.decodeObject(forKey: SerializationKeys.waypointOrder) as? [Any]
    self.warnings = aDecoder.decodeObject(forKey: SerializationKeys.warnings) as? [Any]
    self.copyrights = aDecoder.decodeObject(forKey: SerializationKeys.copyrights) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(summary, forKey: SerializationKeys.summary)
    aCoder.encode(legs, forKey: SerializationKeys.legs)
    aCoder.encode(overviewPolyline, forKey: SerializationKeys.overviewPolyline)
    aCoder.encode(bounds, forKey: SerializationKeys.bounds)
    aCoder.encode(waypointOrder, forKey: SerializationKeys.waypointOrder)
    aCoder.encode(warnings, forKey: SerializationKeys.warnings)
    aCoder.encode(copyrights, forKey: SerializationKeys.copyrights)
  }

}

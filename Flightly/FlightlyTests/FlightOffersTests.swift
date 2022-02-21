//
//  FlightOffersTests.swift
//  FlightlyTests
//
//  Created by Lenka Janosova on 21/02/2022.
//

import XCTest
@testable import Flightly

class FlightOffersTests: XCTestCase {

    func test_given_emptyRepository_whenAppStartsFirstTime_thenDisplayFlightsAndSaveDestinationsAndDate() {
        // given
        let flightDataList = FlightDataList(currency: "EUR", data: mockFlights)
        let repository = DisplayedDestinationsRepositoryDummy()
        let filter = UniqueDestinationFilter(repository: repository)
        let arraySlice = flightDataList.data.prefix(5)
        // when
        let flightsToDisplay = filter.flightsToDisplay(from: flightDataList, for: today)
        // then
        XCTAssertEqual(flightsToDisplay.map { $0.id }, arraySlice.map { $0.id })
        XCTAssertEqual(repository.getData()?.destinationsCityCodes, flightsToDisplay.map { $0.cityCodeTo })
        XCTAssertEqual(repository.getData()?.dateOfUpdate, today)
    }

    func test_given_dataInRepository_whenDayChange_thenDisplayDifferentDestinationsAndSaveNewDestinationsAndDate() {
        // given
        let flightDataList = FlightDataList(currency: "EUR", data: mockFlights)
        let repository = DisplayedDestinationsRepositoryDummy()
        let dataInRepository = DisplayedFlightsModel(
            dateOfUpdate: today,
            destinationsCityCodes: ["AGP", "BCN", "AMS", "LIS", "MAD"]
        )
        repository.save(dataInRepository)
        let filter = UniqueDestinationFilter(repository: repository)
        // when
        let flightsToDisplay = filter.flightsToDisplay(from: flightDataList, for: nextDay)
        // then
        XCTAssert(flightsToDisplay.filter{ dataInRepository.destinationsCityCodes.contains($0.cityCodeTo) }.isEmpty)
        XCTAssertEqual(repository.getData()?.destinationsCityCodes, flightsToDisplay.map { $0.cityCodeTo })
        XCTAssertEqual(repository.getData()?.dateOfUpdate, nextDay)
    }
                                                    
    private var today: DateComponents {
        return Calendar.current.dateComponents([.day, .month, .year], from: .now)
    }

    private var nextDay: DateComponents {
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today.date ?? .now)
        return Calendar.current.dateComponents([.day, .month, .year], from: tomorrow ?? .distantFuture)
    }

    private var mockFlights: [Flight] {
        return [
            makeFlight(id: "1", cityTo: "Madrid", countryTo: Country(code: "ES", name: "Spain"), cityCodeTo: "MAD"),
            makeFlight(id: "2", cityTo: "Barcelona", countryTo: Country(code: "ES", name: "Spain"), cityCodeTo: "BCN"),
            makeFlight(id: "3", cityTo: "Lisabon", countryTo: Country(code: "PT", name: "Portugal"), cityCodeTo: "LIS"),
            makeFlight(id: "4", cityTo: "Amsterdam", countryTo: Country(code: "NL", name: "Netherlands"), cityCodeTo: "AMS"),
            makeFlight(id: "5", cityTo: "Milan", countryTo: Country(code: "IT", name: "Italy"), cityCodeTo: "MIL"),
            makeFlight(id: "6", cityTo: "Malaga", countryTo: Country(code: "ES", name: "Spain"), cityCodeTo: "AGP"),
            makeFlight(id: "7", cityTo: "London", countryTo: Country(code: "EN", name: "England"), cityCodeTo: "LON"),
            makeFlight(id: "8", cityTo: "Paris", countryTo: Country(code: "FR", name: "France"), cityCodeTo: "PAR"),
            makeFlight(id: "9", cityTo: "Munich", countryTo: Country(code: "DE", name: "Germany"), cityCodeTo: "MUC"),
            makeFlight(id: "10", cityTo: "Frankfurt", countryTo: Country(code: "DE", name: "Germany"), cityCodeTo: "FRA")
        ]
    }

    private func makeFlight(
        id: String,
        cityFrom: String = "Prague",
        cityTo: String,
        countryFrom: Country = Country(code: "CZ", name: "Czechia"),
        countryTo: Country,
        cityCodeTo: String,
        departureTime: Int = 1645338300,
        arrivalTime: Int = 1645338300,
        duration: String = "2h 40m",
        price: Float = 20
    ) -> Flight {
        return Flight(
            id: id,
            cityFrom: cityFrom,
            cityTo: cityTo,
            countryFrom: countryFrom,
            countryTo: countryTo,
            cityCodeTo: cityCodeTo,
            departureTime: departureTime,
            arrivalTime: arrivalTime,
            duration: duration,
            price: price
        )
    }

}

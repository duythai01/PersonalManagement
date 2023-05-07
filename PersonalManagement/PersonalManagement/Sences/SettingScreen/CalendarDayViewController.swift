//
//  CustomCalendarView.swift
//  PersonalManagement
//
//  Created by DuyThai on 22/08/2023.
//

import Foundation
import UIKit
import CalendarKit
import EventKit
import EventKitUI

class CalendarViewController: DayViewController {
    private let eventStore = EKEventStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        requestAccessToCalendar()
        subscribeToEKEventStoreNotification()
    }

    func requestAccessToCalendar() {
        eventStore.requestAccess(to: .event) { succes, error in

        }    }

    func subscribeToEKEventStoreNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(eKEventStoreChanged), name: .EKEventStoreChanged, object: nil)
    }

    @objc func eKEventStoreChanged() {
        reloadData()
    }
    override func eventsForDate(_ date: Date) -> [EventDescriptor] {
        let startDate = date
        var oneDayComponents = DateComponents()
        oneDayComponents.day =  1

        let endDate = calendar.date(byAdding: oneDayComponents, to: startDate)!
        let predicate = eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)
        let eventKitEvents = eventStore.events(matching: predicate)
        let calerdarKitEvents = eventKitEvents.map(EventWrapper.init)
        return calerdarKitEvents
    }

    override func dayViewDidSelectEventView(_ eventView: EventView) {
        guard let ckEvent = eventView.descriptor as? EventWrapper else {
            return
        }

        let ekEvent = ckEvent.ekEvent
        let eventViewController = EKEventViewController()
        eventViewController.event = ekEvent
    }
}

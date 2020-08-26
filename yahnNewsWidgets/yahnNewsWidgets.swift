//
//  yahnNewsWidgets.swift
//  yahnNewsWidgets
//
//  Created by Faiz Mokhtar on 26/08/2020.
//  Copyright © 2020 Faiz Mokhtar. All rights reserved.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    public func snapshot(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    public func timeline(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
    public let configuration: ConfigurationIntent
}

struct PlaceholderView : View {
    var body: some View {
        Text("Placeholder View")
    }
}

struct yahnNewsWidgetsEntryView : View {
    var entry: Provider.Entry

    var body: some View {
      VStack(alignment: .leading, spacing: 8) {
        Text("Latest News")
          .font(.caption)
          .fontWeight(.bold)
        VStack(alignment: .leading, spacing: 4) {
          Text("Arwes - Futuristic Sci-Fi/ Cyberpunk Graphical User Interface Framework")
            .font(.subheadline)
          Text("arweslabs.dev")
            .font(.footnote)
            .fontWeight(.medium)
            .foregroundColor(.gray)
        }
      }
      .padding(10)
    }
}

@main
struct yahnNewsWidgets: Widget {
    private let kind: String = "yahnNewsWidgets"

    public var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider(), placeholder: PlaceholderView()) { entry in
            yahnNewsWidgetsEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct yahnNewsWidgets_Previews: PreviewProvider {
    static var previews: some View {
        yahnNewsWidgetsEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

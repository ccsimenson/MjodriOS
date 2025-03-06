import SwiftUI

struct MeadHallView: View {
    @StateObject private var store = MeadBatchStore()
    @State private var showingAddBatch = false
    @State private var showingBatchDetail: MeadBatch?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                Text("Welcome to the Mead Hall")
                    .font(VikingTheme.TextStyle.titleFont)
                    .foregroundColor(VikingTheme.Colors.gold)
                
                // Add New Batch Button
                Button("Begin New Batch") {
                    showingAddBatch = true
                }
                .buttonStyle(VikingTheme.VikingButtonStyle())
                .padding(.horizontal)
                
                // Active Batches
                if !activeBatches.isEmpty {
                    BatchSection(title: "Active Fermentations", batches: activeBatches)
                }
                
                // Completed Batches
                if !completedBatches.isEmpty {
                    BatchSection(title: "Completed Brews", batches: completedBatches)
                }
            }
            .padding()
        }
        .background(VikingTheme.Colors.darkWood.ignoresSafeArea())
        .sheet(isPresented: $showingAddBatch) {
            AddBatchView(store: store)
        }
        .sheet(item: $showingBatchDetail) { batch in
            BatchDetailView(batch: batch, store: store)
        }
        .navigationTitle("Mead Hall")
    }
    
    private var activeBatches: [MeadBatch] {
        store.batches.filter { $0.statusEnum == .active }
    }
    
    private var completedBatches: [MeadBatch] {
        store.batches.filter { $0.statusEnum == .completed }
    }
}

struct BatchSection: View {
    let title: String
    let batches: [MeadBatch]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(VikingTheme.TextStyle.subtitleFont)
                .foregroundColor(VikingTheme.Colors.gold)
            
            ForEach(batches) { batch in
                BatchCard(batch: batch)
            }
        }
        .padding(.horizontal)
    }
}

struct BatchCard: View {
    let batch: MeadBatch
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(batch.name)
                    .font(VikingTheme.TextStyle.bodyFont.bold())
                    .foregroundColor(VikingTheme.Colors.gold)
                
                Spacer()
                
                Text(batch.statusEnum.rawValue)
                    .font(VikingTheme.TextStyle.bodyFont)
                    .foregroundColor(batch.statusEnum.color)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .stroke(batch.statusEnum.color, lineWidth: 1)
                    )
            }
            
            Text(batch.type)
                .font(VikingTheme.TextStyle.bodyFont)
                .foregroundColor(VikingTheme.Colors.parchment)
            
            HStack {
                ProgressView(value: calculateProgress(batch))
                    .tint(VikingTheme.Colors.gold)
                
                Text(String(format: "%.1f%%", calculateProgress(batch) * 100))
                    .font(VikingTheme.TextStyle.bodyFont)
                    .foregroundColor(VikingTheme.Colors.gold)
            }
            
            Text("Last Updated: \(formatDate(batch.lastUpdated))")
                .font(VikingTheme.TextStyle.bodyFont)
                .foregroundColor(VikingTheme.Colors.parchment.opacity(0.8))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(VikingTheme.Colors.darkWood)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(VikingTheme.Colors.gold.opacity(0.3), lineWidth: 1)
                )
        )
        .shadow(color: Color.black.opacity(0.2), radius: 4)
    }
    
    private func calculateProgress(_ batch: MeadBatch) -> Double {
        let totalChange = batch.originalGravity - batch.targetGravity
        let currentChange = batch.originalGravity - batch.currentGravity
        return min(max(currentChange / totalChange, 0), 1)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

struct AddBatchView: View {
    @Environment(\.dismiss) var dismiss
    let store: MeadBatchStore
    
    @State private var name = ""
    @State private var type = ""
    @State private var originalGravity = ""
    @State private var targetGravity = ""
    @State private var temperature = ""
    @State private var notes = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    TextField("Batch Name", text: $name)
                        .textFieldStyle(VikingTheme.VikingTextFieldStyle())
                    
                    TextField("Mead Type", text: $type)
                        .textFieldStyle(VikingTheme.VikingTextFieldStyle())
                    
                    TextField("Original Gravity", text: $originalGravity)
                        .textFieldStyle(VikingTheme.VikingTextFieldStyle())
                        .keyboardType(.decimalPad)
                    
                    TextField("Target Gravity", text: $targetGravity)
                        .textFieldStyle(VikingTheme.VikingTextFieldStyle())
                        .keyboardType(.decimalPad)
                    
                    TextField("Temperature (°F)", text: $temperature)
                        .textFieldStyle(VikingTheme.VikingTextFieldStyle())
                        .keyboardType(.decimalPad)
                    
                    TextEditor(text: $notes)
                        .frame(height: 100)
                        .padding()
                        .background(VikingTheme.Colors.parchment)
                        .cornerRadius(8)
                }
                .padding()
            }
            .background(VikingTheme.Colors.darkWood.ignoresSafeArea())
            .navigationTitle("New Batch")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(VikingTheme.Colors.gold)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveBatch()
                    }
                    .foregroundColor(VikingTheme.Colors.gold)
                }
            }
        }
    }
    
    private func saveBatch() {
        guard let og = Double(originalGravity),
              let tg = Double(targetGravity),
              let temp = Double(temperature) else {
            return
        }
        
        store.addBatch(
            name: name,
            type: type,
            originalGravity: og,
            targetGravity: tg,
            temperature: temp,
            notes: notes
        )
        
        dismiss()
    }
}

struct BatchDetailView: View {
    @Environment(\.dismiss) var dismiss
    let batch: MeadBatch
    let store: MeadBatchStore
    
    @State private var currentGravity: String = ""
    @State private var temperature: String = ""
    @State private var notes: String = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Current Values
                    GroupBox("Current Readings") {
                        VStack(spacing: 16) {
                            TextField("Current Gravity", text: $currentGravity)
                                .textFieldStyle(VikingTheme.VikingTextFieldStyle())
                                .keyboardType(.decimalPad)
                            
                            TextField("Temperature (°F)", text: $temperature)
                                .textFieldStyle(VikingTheme.VikingTextFieldStyle())
                                .keyboardType(.decimalPad)
                        }
                    }
                    .groupBoxStyle(VikingGroupBoxStyle())
                    
                    // Batch Info
                    GroupBox("Batch Details") {
                        VStack(alignment: .leading, spacing: 12) {
                            DetailRow(label: "Original Gravity:", value: String(format: "%.3f", batch.originalGravity))
                            DetailRow(label: "Target Gravity:", value: String(format: "%.3f", batch.targetGravity))
                            DetailRow(label: "Start Date:", value: formatDate(batch.startDate))
                        }
                    }
                    .groupBoxStyle(VikingGroupBoxStyle())
                    
                    // Notes
                    GroupBox("Brewing Notes") {
                        TextEditor(text: $notes)
                            .frame(height: 100)
                            .padding()
                            .background(VikingTheme.Colors.parchment)
                            .cornerRadius(8)
                    }
                    .groupBoxStyle(VikingGroupBoxStyle())
                    
                    // Status Toggle
                    if batch.statusEnum == .active {
                        Button("Mark as Completed") {
                            updateBatchStatus()
                        }
                        .buttonStyle(VikingTheme.VikingButtonStyle())
                    }
                }
                .padding()
            }
            .background(VikingTheme.Colors.darkWood.ignoresSafeArea())
            .navigationTitle(batch.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Update") {
                        updateBatch()
                    }
                    .foregroundColor(VikingTheme.Colors.gold)
                }
            }
        }
        .onAppear {
            currentGravity = String(format: "%.3f", batch.currentGravity)
            temperature = String(format: "%.1f", batch.temperature)
            notes = batch.notes
        }
    }
    
    private func updateBatch() {
        if let gravity = Double(currentGravity),
           let temp = Double(temperature) {
            batch.currentGravity = gravity
            batch.temperature = temp
            batch.notes = notes
            store.updateBatch(batch)
        }
        dismiss()
    }
    
    private func updateBatchStatus() {
        batch.statusEnum = .completed
        store.updateBatch(batch)
        dismiss()
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

struct DetailRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(VikingTheme.TextStyle.bodyFont)
                .foregroundColor(VikingTheme.Colors.gold)
            Spacer()
            Text(value)
                .font(VikingTheme.TextStyle.bodyFont)
                .foregroundColor(VikingTheme.Colors.parchment)
        }
    }
}

#Preview {
    NavigationView {
        MeadHallView()
    }
}

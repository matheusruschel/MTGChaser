//
//  SVGImageView.swift
//  MTGChaser
//
//  Created by Bruna on 2025-04-24.
//

import SwiftUI
import SVGKit

struct SVGImageView: UIViewRepresentable {
    let url: URL
    var size: CGSize
    var color: Color
    
    class Coordinator {
        var imageView: SVGKFastImageView?
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    func makeUIView(context: Context) -> UIView {
        
        guard let imageView = SVGKFastImageView(svgkImage: SVGKImage()) else { return UIView() }
        
        context.coordinator.imageView = imageView
        
        loadSVGAsync(into: imageView)
        return imageView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        
        guard let view = uiView as? SVGKFastImageView else { return }
        
        view.contentMode = .scaleAspectFit
        view.image.size = size
        
        if let rootLayer = view.image.caLayerTree {
            let uiColor = UIColor(color)
            applyFillColor(to: rootLayer, color: uiColor)
        }
    }
    
    private func loadSVGAsync(into imageView: SVGKFastImageView) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let data = try? Data(contentsOf: url),
                  let svgImage = SVGKImage(data: data) else {
                print("⚠️ Failed to load or parse SVG from: \(url)")
                return
            }
            
            svgImage.size = size
            
            Task { @MainActor in
                imageView.image = svgImage
                
                let tintColor: UIColor = UIColor(color)
                if let rootLayer = svgImage.caLayerTree {
                    applyFillColor(to: rootLayer, color: tintColor)
                }
            }
        }
    }
    
    private func applyFillColor(to layer: CALayer, color: UIColor) {
        if let shapeLayer = layer as? CAShapeLayer {
            shapeLayer.fillColor = color.cgColor
        }

        layer.sublayers?.forEach { applyFillColor(to: $0, color: color) }
    }
}

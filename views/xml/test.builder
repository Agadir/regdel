xml.root {
    xml.mynode("hi")
    xml.subtree {
        xml.subnode(:myattr=>"yo") {
            xml.anothernode(:myattr=>"cya")
        }
    }
}

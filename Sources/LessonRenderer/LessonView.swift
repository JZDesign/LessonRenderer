import SwiftUI
import AVKit

public struct LessonView: View {
    let lesson: Lesson
    
    public init(lesson: Lesson) {
        self.lesson = lesson
    }
    
    public var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(lesson.allActivities(), id: \.0) { (offset, activity) in
                    switch activity {
                    case .image(let image):
                        VStack {
                            AsyncImage(url: image.imageUrl) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .cornerRadius(8)
                                    .shadow(color: .primary.opacity(0.4), radius: 5)
                            } placeholder: {
                                ProgressView()
                            }
                            if !image.details.isEmpty {
                                Text(image.detailsMarkdown()) .textSelection(.enabled)
                                    .padding()

                            }
                        }
                    case .audio(let audio):
                        VStack {
                            AudioView(url: audio.audioUrl, shouldPlayAutomatically: audio.shouldAutoPlay)
                                .frame(maxWidth: .infinity)
                            if !audio.transcription.isEmpty {
                                HStack {
                                    Text("Transcription")
                                        .font(.callout)
                                        .fontWeight(.semibold)
                                        .opacity(0.5)
                                    Spacer()
                                }
                                .padding(.bottom)
                                
                                Text(audio.transcrptionMarkdown())            .textSelection(.enabled)

                            }
                        }
                    case .video(let video):
                        VideoPlayerView(url: video.videoUrl, shouldPlayImmediately: video.shouldAutoPlay)
                            .frame(maxWidth: .infinity, minHeight: 280, maxHeight: 500)
                            .cornerRadius(8)
                            .shadow(color: .primary.opacity(0.4), radius: 5)

                        
                        if !video.transcription.isEmpty {
                            VStack {
                                HStack {
                                    Text("Transcription")
                                        .font(.callout)
                                        .fontWeight(.semibold)
                                        .opacity(0.5)
                                    Spacer()
                                }
                                .padding(.bottom)
                                
                                Text(video.transcrptionMarkdown())
                                    .textSelection(.enabled)

                            }
                        }
                    case .sectionHeading(let heading):
                        heading.toHeaderView()
                            .padding(.top, 42)
                            .textSelection(.enabled)
                    case .read(let content):
                        Text(content.toMarkdown())            .textSelection(.enabled)
                    }
                }
            }
            .padding()
            .frame(maxWidth: 624)
            .frame(maxWidth: .infinity)
        }
        .navigationTitle(Text(lesson.title))
    }
}

extension Lesson {
    func allActivities() -> [(Int, Activity)] {
        activities.enumerated().map { ($0.offset, $0.element) }
    }
}


#Preview {
    LessonView(
        lesson: .init(
            id: .init(),
            title: "This is a test",
            activities: [
                .sectionHeading(.init(heading: "**Watch this**", size: .large)),
                .video(.init(
                    url: URL(string: "https://media.developer.dolby.com/DDP/MP4_HPL40_30fps_channel_id_71.mp4")!,
                    transcription: "*This* is a **video** from [Dolby](https://developer.dolby.com/tools-media/sample-media/video-streams/hd-video-streams) I'm using to test things out",
                    shouldAutoPlay: false
                )),
                .sectionHeading(.init(heading: "Now **read** *this*", size: .medium)),
                .read(.init(content: """

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vice-regis errat cibum ac frater surgit gloriam amico. Vitulus cavet. Arise for our help, and redeem us for thy mercies' sake (**Psalm** *44:26*). Rex fugit causidicum gaudio atque miles incedit quia antilope est. Leopardus patitur mercator. Therefore he brought down their heart with labour; they fell down, and [there was] none to help (**Psalm** *107:12*). Puella cadit liber atque auctor locat spem sed antilope fungitur portam sed pater amat silvam auro. Mungo dolent avem tineam aut pater credit aut faber colit sed papio capit pontem aut dominus munit pugnam columini. I will walk before the LORD in the land of the living (**Psalm** *116:9*). Amicus patitur mercator vel filia mitigat locusta domino quia rosmarus vincit psittaco pedi. Ursus colit vipera cantatorem periculo sed lynx regit sed simia dormit. Concerning the works of men, by the word of thy lips I have kept [me from] the paths of the destroyer (**Psalm** *17:4*).

Puer munit animal philosophum ac vulpes exodit capillum corpori initio sed cricetus mitigat caldarium ac taurus dicit corpus asteriam. Cancer iubet cor nam aries valet iter civi sed cancer trahit raia nam locusta scindit periculum candelabro. Let destruction come upon him at unawares; and let his net that he hath hid catch himself: into that very destruction let him fall (**Psalm** *35:8*). Sartor mitigat mercator servo. Cancer evadit. How long will ye imagine mischief against a man? ye shall be slain all of you: as a bowing wall [shall ye be, and as] a tottering fence (**Psalm** *62:3*). Frater stat nutrix viperam nam auriga creat nubem professorem. Ovis bibit nam vultur claudit sellam. When I consider thy heavens, the work of thy fingers, the moon and the stars, which thou hast ordained; (**Psalm** *8:3*). Hyena vexat. Obstetrix urit discipulam vel jaguarius poscit musico nam vacca recusat porce ac violinista nutrit silvam procyonem. A father of the fatherless, and a judge of the widows, [is] God in his holy habitation (**Psalm** *68:5*).

Antilope ludit equum ac psittacus fingit leonem domicilio vel mungo occidit animal terrae aut vitulus vendit cygno flammae. Coquus luit discipulam tineam vel antilope navigat quia hippopotamus videt. Nevertheless he regarded their affliction, when he heard their cry (**Psalm** *106:44*). Pictor pellit vel coquus servat corve. Mungo videt vice-regis vel gallina veretur sartor et giraffa sperat carcharia ac simia scit cantator judicem. For, lo, they that are far from thee shall perish: thou hast destroyed all them that go a whoring from thee (**Psalm** *73:27*). Miles recusat portam veterinarium aut capra surgit atque agnus curat nam coquus frangit fontem sed struthio addit ovis terrae. Capra vincit vipera vel passer parat serpens fortunae quia gubernator pandit corve leporem. Purge me with hyssop, and I shall be clean: wash me, and I shall be whiter than snow (**Psalm** *51:7*). Servus recedit penguinus vel miles cupit mensam. Explorator decorat errorem atque vulpes appellat avem. O LORD God of hosts, how long wilt thou be angry against the prayer of thy people? (**Psalm** *80:4*).

Causidicus amplexatur coronam poetae vel causidicus irascitur nam piscator tendit. Sciurus lugent plumbrio procyonem ac ovis moratur sed formica laborat et apis iacit granum aut orator narrat leopardo simiam. He smote also all the firstborn in their land, the chief of all their strength (**Psalm** *105:36*). Anas errat quia raia pendit metallario. Veterinarius stat pedem codici nam gubernator habet nam plumbarius gerit quia procyon ambulat pugnam et vitulus stat lepus leopardum. Yea, the sparrow hath found an house, and the swallow a nest for herself, where she may lay her young, [even] thine altars, O LORD of hosts, my King, and my God (**Psalm** *84:3*).

Judex desinit aut cervus frustrat vel corvus vescitur turtur atque piscator rogat psittaco plumbarium. Cygnus desiderat ferrum lecto quia poeta probat capillum periculo aut delphinus curat et medicus negat. Thou puttest away all the wicked of the earth [like] dross: therefore I love thy testimonies (**Psalm** *119:119*). Tonsor donat codicem cantatorem sed ancilla picturat terrorem servo. Nutrix petit et imperator pulsat struthio. Praise ye the LORD O give thanks unto the LORD; for [he is] good: for his mercy [endureth] for ever (**Psalm** *106:1*). Delphinus lugent paritem animali. Apis sperat lacerto terrori ac feles quiescit porce codici cibo. Let their way be dark and slippery: and let the angel of the LORD persecute them (**Psalm** *35:6*).
""")),
                .sectionHeading(.init(heading: "Now **listen** to *this*", size: .medium)),
                .audio(.init(url: URL(string: "https://cdn.freesound.org/previews/730/730446_15695547-lq.mp3")!, transcription: "This is an example", shouldAutoPlay: false)),
                .sectionHeading(.init(heading: "Now **watch** *this*", size: .medium)),
                .video(.init(
                    url: URL(string: "https://media.developer.dolby.com/Atmos/MP4/Universe_Fury2.mp4")!,
                    transcription: "*This* is a **video** from [Dolby](https://developer.dolby.com/tools-media/sample-media/video-streams/hd-video-streams) I'm using to test things out",
                    shouldAutoPlay: false
                )),
                .image(.init(url: URL(string: "https://www.picserver.org/assets/library/2020-10-31/originals/example1.jpg")!, details: "This is a bit of info about that image"))
            ]
        )
    )
    .tint(.red)
//    .background {
//        LinearGradient(stops: [
//            .init(color: .black, location: .zero),
//            .init(color: .blue, location: 1)
//        ], startPoint: .topLeading, endPoint: .bottomTrailing)
//        .scaleEffect(3)
//        .edgesIgnoringSafeArea(.all)
//    }
}

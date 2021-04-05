const __jmp_buf = NTuple{64, Cint}

struct __sigset_t
    __val::NTuple{32, Culong}
end

struct __jmp_buf_tag
    __jmpbuf::__jmp_buf
    __mask_was_saved::Cint
    __saved_mask::__sigset_t
end

const jmp_buf = NTuple{1, __jmp_buf_tag}

const countT = Cint

struct setelemT
    data::NTuple{4, UInt8}
end

function Base.getproperty(x::Ptr{setelemT}, f::Symbol)
    f === :p && return Ptr{Ptr{Cvoid}}(x + 0)
    f === :i && return Ptr{Cint}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::setelemT, f::Symbol)
    r = Ref{setelemT}(x)
    ptr = Base.unsafe_convert(Ptr{setelemT}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{setelemT}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct setT
    maxsize::Cint
    e::NTuple{1, setelemT}
end

function Base.getproperty(x::Ptr{setT}, f::Symbol)
    f === :maxsize && return Ptr{Cint}(x + 0)
    f === :e && return Ptr{NTuple{1, setelemT}}(x + 4)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{setT}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

@enum qh_PRINT::UInt32 begin
    qh_PRINTnone = 0
    qh_PRINTarea = 1
    qh_PRINTaverage = 2
    qh_PRINTcoplanars = 3
    qh_PRINTcentrums = 4
    qh_PRINTfacets = 5
    qh_PRINTfacets_xridge = 6
    qh_PRINTgeom = 7
    qh_PRINTids = 8
    qh_PRINTinner = 9
    qh_PRINTneighbors = 10
    qh_PRINTnormals = 11
    qh_PRINTouter = 12
    qh_PRINTmaple = 13
    qh_PRINTincidences = 14
    qh_PRINTmathematica = 15
    qh_PRINTmerges = 16
    qh_PRINToff = 17
    qh_PRINToptions = 18
    qh_PRINTpointintersect = 19
    qh_PRINTpointnearest = 20
    qh_PRINTpoints = 21
    qh_PRINTqhull = 22
    qh_PRINTsize = 23
    qh_PRINTsummary = 24
    qh_PRINTtriangles = 25
    qh_PRINTvertices = 26
    qh_PRINTvneighbors = 27
    qh_PRINTextremes = 28
    qh_PRINTEND = 29
end

struct facetT
    data::NTuple{88, UInt8}
end

function Base.getproperty(x::Ptr{facetT}, f::Symbol)
    f === :furthestdist && return Ptr{Cdouble}(x + 0)
    f === :maxoutside && return Ptr{Cdouble}(x + 8)
    f === :offset && return Ptr{Cdouble}(x + 16)
    f === :normal && return Ptr{Ptr{Cdouble}}(x + 24)
    f === :f && return Ptr{__JL_Ctag_9}(x + 32)
    f === :center && return Ptr{Ptr{Cdouble}}(x + 40)
    f === :previous && return Ptr{Ptr{facetT}}(x + 44)
    f === :next && return Ptr{Ptr{facetT}}(x + 48)
    f === :vertices && return Ptr{Ptr{setT}}(x + 52)
    f === :ridges && return Ptr{Ptr{setT}}(x + 56)
    f === :neighbors && return Ptr{Ptr{setT}}(x + 60)
    f === :outsideset && return Ptr{Ptr{setT}}(x + 64)
    f === :coplanarset && return Ptr{Ptr{setT}}(x + 68)
    f === :visitid && return Ptr{Cuint}(x + 72)
    f === :id && return Ptr{Cuint}(x + 76)
    f === :nummerge && return Ptr{Cuint}(x + 80)
    f === :tricoplanar && return (Ptr{Cuint}(x + 81), 1, 1)
    f === :newfacet && return (Ptr{Cuint}(x + 81), 2, 1)
    f === :visible && return (Ptr{Cuint}(x + 81), 3, 1)
    f === :toporient && return (Ptr{Cuint}(x + 81), 4, 1)
    f === :simplicial && return (Ptr{Cuint}(x + 81), 5, 1)
    f === :seen && return (Ptr{Cuint}(x + 81), 6, 1)
    f === :seen2 && return (Ptr{Cuint}(x + 81), 7, 1)
    f === :flipped && return Ptr{Cuint}(x + 82)
    f === :upperdelaunay && return (Ptr{Cuint}(x + 82), 1, 1)
    f === :notfurthest && return (Ptr{Cuint}(x + 82), 2, 1)
    f === :good && return (Ptr{Cuint}(x + 82), 3, 1)
    f === :isarea && return (Ptr{Cuint}(x + 82), 4, 1)
    f === :dupridge && return (Ptr{Cuint}(x + 82), 5, 1)
    f === :mergeridge && return (Ptr{Cuint}(x + 82), 6, 1)
    f === :mergeridge2 && return (Ptr{Cuint}(x + 82), 7, 1)
    f === :coplanarhorizon && return Ptr{Cuint}(x + 83)
    f === :mergehorizon && return (Ptr{Cuint}(x + 83), 1, 1)
    f === :cycledone && return (Ptr{Cuint}(x + 83), 2, 1)
    f === :tested && return (Ptr{Cuint}(x + 83), 3, 1)
    f === :keepcentrum && return (Ptr{Cuint}(x + 83), 4, 1)
    f === :newmerge && return (Ptr{Cuint}(x + 83), 5, 1)
    f === :degenerate && return (Ptr{Cuint}(x + 83), 6, 1)
    f === :redundant && return (Ptr{Cuint}(x + 83), 7, 1)
    return getfield(x, f)
end

function Base.getproperty(x::facetT, f::Symbol)
    r = Ref{facetT}(x)
    ptr = Base.unsafe_convert(Ptr{facetT}, r)
    fptr = getproperty(ptr, f)
    begin
        if fptr isa Ptr
            return GC.@preserve(r, unsafe_load(fptr))
        else
            (baseptr, offset, width) = fptr
            ty = eltype(baseptr)
            i8 = GC.@preserve(r, unsafe_load(baseptr))
            bitstr = bitstring(i8)
            sig = bitstr[(end - offset) - (width - 1):end - offset]
            zexted = lpad(sig, 8 * sizeof(ty), '0')
            return parse(ty, zexted; base = 2)
        end
    end
end

function Base.setproperty!(x::Ptr{facetT}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct ridgeT
    data::NTuple{20, UInt8}
end

function Base.getproperty(x::Ptr{ridgeT}, f::Symbol)
    f === :vertices && return Ptr{Ptr{setT}}(x + 0)
    f === :top && return Ptr{Ptr{facetT}}(x + 4)
    f === :bottom && return Ptr{Ptr{facetT}}(x + 8)
    f === :id && return Ptr{Cuint}(x + 12)
    f === :seen && return Ptr{Cuint}(x + 16)
    f === :tested && return (Ptr{Cuint}(x + 16), 1, 1)
    f === :nonconvex && return (Ptr{Cuint}(x + 16), 2, 1)
    f === :mergevertex && return (Ptr{Cuint}(x + 16), 3, 1)
    f === :mergevertex2 && return (Ptr{Cuint}(x + 16), 4, 1)
    f === :simplicialtop && return (Ptr{Cuint}(x + 16), 5, 1)
    f === :simplicialbot && return (Ptr{Cuint}(x + 16), 6, 1)
    return getfield(x, f)
end

function Base.getproperty(x::ridgeT, f::Symbol)
    r = Ref{ridgeT}(x)
    ptr = Base.unsafe_convert(Ptr{ridgeT}, r)
    fptr = getproperty(ptr, f)
    begin
        if fptr isa Ptr
            return GC.@preserve(r, unsafe_load(fptr))
        else
            (baseptr, offset, width) = fptr
            ty = eltype(baseptr)
            i8 = GC.@preserve(r, unsafe_load(baseptr))
            bitstr = bitstring(i8)
            sig = bitstr[(end - offset) - (width - 1):end - offset]
            zexted = lpad(sig, 8 * sizeof(ty), '0')
            return parse(ty, zexted; base = 2)
        end
    end
end

function Base.setproperty!(x::Ptr{ridgeT}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

@enum qh_CENTER::UInt32 begin
    qh_ASnone = 0
    qh_ASvoronoi = 1
    qh_AScentrum = 2
end

struct qhmemT
    BUFsize::Cint
    BUFinit::Cint
    TABLEsize::Cint
    NUMsizes::Cint
    LASTsize::Cint
    ALIGNmask::Cint
    freelists::Ptr{Ptr{Cvoid}}
    sizetable::Ptr{Cint}
    indextable::Ptr{Cint}
    curbuffer::Ptr{Cvoid}
    freemem::Ptr{Cvoid}
    freesize::Cint
    tempstack::Ptr{setT}
    ferr::Ptr{Libc.FILE}
    IStracing::Cint
    cntquick::Cint
    cntshort::Cint
    cntlong::Cint
    freeshort::Cint
    freelong::Cint
    totbuffer::Cint
    totdropped::Cint
    totfree::Cint
    totlong::Cint
    maxlong::Cint
    totshort::Cint
    totunused::Cint
    cntlarger::Cint
    totlarger::Cint
end

struct intrealT
    data::NTuple{8, UInt8}
end

function Base.getproperty(x::Ptr{intrealT}, f::Symbol)
    f === :i && return Ptr{Cint}(x + 0)
    f === :r && return Ptr{Cdouble}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::intrealT, f::Symbol)
    r = Ref{intrealT}(x)
    ptr = Base.unsafe_convert(Ptr{intrealT}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{intrealT}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct qhstatT
    stats::NTuple{249, intrealT}
    id::NTuple{259, Cuchar}
    doc::NTuple{249, Ptr{Cchar}}
    count::NTuple{249, Cshort}
    type::NTuple{249, Cchar}
    printed::NTuple{249, Cchar}
    init::NTuple{9, intrealT}
    next::Cint
    precision::Cint
    vridges::Cint
    tempi::Cint
    tempr::Cdouble
end

struct qhT
    ALLpoints::Cuint
    ALLOWshort::Cuint
    ALLOWwarning::Cuint
    ALLOWwide::Cuint
    ANGLEmerge::Cuint
    APPROXhull::Cuint
    MINoutside::Cdouble
    ANNOTATEoutput::Cuint
    ATinfinity::Cuint
    AVOIDold::Cuint
    BESToutside::Cuint
    CDDinput::Cuint
    CDDoutput::Cuint
    CHECKduplicates::Cuint
    CHECKfrequently::Cuint
    premerge_cos::Cdouble
    postmerge_cos::Cdouble
    DELAUNAY::Cuint
    DOintersections::Cuint
    DROPdim::Cint
    FLUSHprint::Cuint
    FORCEoutput::Cuint
    GOODpoint::Cint
    GOODpointp::Ptr{Cdouble}
    GOODthreshold::Cuint
    GOODvertex::Cint
    GOODvertexp::Ptr{Cdouble}
    HALFspace::Cuint
    ISqhullQh::Cuint
    IStracing::Cint
    KEEParea::Cint
    KEEPcoplanar::Cuint
    KEEPinside::Cuint
    KEEPmerge::Cint
    KEEPminArea::Cdouble
    MAXcoplanar::Cdouble
    MAXwide::Cint
    MERGEexact::Cuint
    MERGEindependent::Cuint
    MERGING::Cuint
    premerge_centrum::Cdouble
    postmerge_centrum::Cdouble
    MERGEpinched::Cuint
    MERGEvertices::Cuint
    MINvisible::Cdouble
    NOnarrow::Cuint
    NOnearinside::Cuint
    NOpremerge::Cuint
    ONLYgood::Cuint
    ONLYmax::Cuint
    PICKfurthest::Cuint
    POSTmerge::Cuint
    PREmerge::Cuint
    PRINTcentrums::Cuint
    PRINTcoplanar::Cuint
    PRINTdim::Cint
    PRINTdots::Cuint
    PRINTgood::Cuint
    PRINTinner::Cuint
    PRINTneighbors::Cuint
    PRINTnoplanes::Cuint
    PRINToptions1st::Cuint
    PRINTouter::Cuint
    PRINTprecision::Cuint
    PRINTout::NTuple{29, qh_PRINT}
    PRINTridges::Cuint
    PRINTspheres::Cuint
    PRINTstatistics::Cuint
    PRINTsummary::Cuint
    PRINTtransparent::Cuint
    PROJECTdelaunay::Cuint
    PROJECTinput::Cint
    RANDOMdist::Cuint
    RANDOMfactor::Cdouble
    RANDOMa::Cdouble
    RANDOMb::Cdouble
    RANDOMoutside::Cuint
    REPORTfreq::Cint
    REPORTfreq2::Cint
    RERUN::Cint
    ROTATErandom::Cint
    SCALEinput::Cuint
    SCALElast::Cuint
    SETroundoff::Cuint
    SKIPcheckmax::Cuint
    SKIPconvex::Cuint
    SPLITthresholds::Cuint
    STOPadd::Cint
    STOPcone::Cint
    STOPpoint::Cint
    TESTpoints::Cint
    TESTvneighbors::Cuint
    TRACElevel::Cint
    TRACElastrun::Cint
    TRACEpoint::Cint
    TRACEdist::Cdouble
    TRACEmerge::Cint
    TRIangulate::Cuint
    TRInormals::Cuint
    UPPERdelaunay::Cuint
    USEstdout::Cuint
    VERIFYoutput::Cuint
    VIRTUALmemory::Cuint
    VORONOI::Cuint
    AREAfactor::Cdouble
    DOcheckmax::Cuint
    feasible_string::Ptr{Cchar}
    feasible_point::Ptr{Cdouble}
    GETarea::Cuint
    KEEPnearinside::Cuint
    hull_dim::Cint
    input_dim::Cint
    num_points::Cint
    first_point::Ptr{Cdouble}
    POINTSmalloc::Cuint
    input_points::Ptr{Cdouble}
    input_malloc::Cuint
    qhull_command::NTuple{256, Cchar}
    qhull_commandsiz2::Cint
    rbox_command::NTuple{256, Cchar}
    qhull_options::NTuple{512, Cchar}
    qhull_optionlen::Cint
    qhull_optionsiz::Cint
    qhull_optionsiz2::Cint
    run_id::Cint
    VERTEXneighbors::Cuint
    ZEROcentrum::Cuint
    upper_threshold::Ptr{Cdouble}
    lower_threshold::Ptr{Cdouble}
    upper_bound::Ptr{Cdouble}
    lower_bound::Ptr{Cdouble}
    ANGLEround::Cdouble
    centrum_radius::Cdouble
    cos_max::Cdouble
    DISTround::Cdouble
    MAXabs_coord::Cdouble
    MAXlastcoord::Cdouble
    MAXoutside::Cdouble
    MAXsumcoord::Cdouble
    MAXwidth::Cdouble
    MINdenom_1::Cdouble
    MINdenom::Cdouble
    MINdenom_1_2::Cdouble
    MINdenom_2::Cdouble
    MINlastcoord::Cdouble
    NEARzero::Ptr{Cdouble}
    NEARinside::Cdouble
    ONEmerge::Cdouble
    outside_err::Cdouble
    WIDEfacet::Cdouble
    NARROWhull::Cuint
    qhull::NTuple{6, Cchar}
    errexit::jmp_buf
    jmpXtra::NTuple{40, Cchar}
    restartexit::jmp_buf
    jmpXtra2::NTuple{40, Cchar}
    # fin::Ptr{Libc.FILE}
    fin::Ptr{Libc.FILE}
    # fout::Ptr{Libc.FILE}
    fout::Ptr{Libc.FILE}
    # ferr::Ptr{Libc.FILE}
    ferr::Ptr{Libc.FILE}
    interior_point::Ptr{Cdouble}
    normal_size::Cint
    center_size::Cint
    TEMPsize::Cint
    facet_list::Ptr{facetT}
    facet_tail::Ptr{facetT}
    facet_next::Ptr{facetT}
    newfacet_list::Ptr{facetT}
    visible_list::Ptr{facetT}
    num_visible::Cint
    tracefacet_id::Cuint
    tracefacet::Ptr{facetT}
    traceridge_id::Cuint
    traceridge::Ptr{ridgeT}
    tracevertex_id::Cuint
    # tracevertex::Ptr{vertexT}
    tracevertex::Ptr{Cvoid}
    # vertex_list::Ptr{vertexT}
    vertex_list::Ptr{Cvoid}
    # vertex_tail::Ptr{vertexT}
    vertex_tail::Ptr{Cvoid}
    # newvertex_list::Ptr{vertexT}
    newvertex_list::Ptr{Cvoid}
    num_facets::Cint
    num_vertices::Cint
    num_outside::Cint
    num_good::Cint
    facet_id::Cuint
    ridge_id::Cuint
    vertex_id::Cuint
    first_newfacet::Cuint
    hulltime::Culong
    ALLOWrestart::Cuint
    build_cnt::Cint
    CENTERtype::qh_CENTER
    furthest_id::Cint
    last_errcode::Cint
    GOODclosest::Ptr{facetT}
    coplanar_apex::Ptr{Cdouble}
    hasAreaVolume::Cuint
    hasTriangulation::Cuint
    isRenameVertex::Cuint
    JOGGLEmax::Cdouble
    maxoutdone::Cuint
    max_outside::Cdouble
    max_vertex::Cdouble
    min_vertex::Cdouble
    NEWfacets::Cuint
    NEWtentative::Cuint
    findbestnew::Cuint
    findbest_notsharp::Cuint
    NOerrexit::Cuint
    PRINTcradius::Cdouble
    PRINTradius::Cdouble
    POSTmerging::Cuint
    printoutvar::Cint
    printoutnum::Cint
    repart_facetid::Cuint
    retry_addpoint::Cint
    QHULLfinished::Cuint
    totarea::Cdouble
    totvol::Cdouble
    visit_id::Cuint
    vertex_visit::Cuint
    WAScoplanar::Cuint
    ZEROall_ok::Cuint
    facet_mergeset::Ptr{setT}
    degen_mergeset::Ptr{setT}
    vertex_mergeset::Ptr{setT}
    hash_table::Ptr{setT}
    other_points::Ptr{setT}
    del_vertices::Ptr{setT}
    gm_matrix::Ptr{Cdouble}
    gm_row::Ptr{Ptr{Cdouble}}
    line::Ptr{Cchar}
    maxline::Cint
    half_space::Ptr{Cdouble}
    temp_malloc::Ptr{Cdouble}
    ERREXITcalled::Cuint
    firstcentrum::Cuint
    old_randomdist::Cuint
    coplanarfacetset::Ptr{setT}
    last_low::Cdouble
    last_high::Cdouble
    last_newhigh::Cdouble
    lastcpu::Cdouble
    lastfacets::Cint
    lastmerges::Cint
    lastplanes::Cint
    lastdist::Cint
    lastreport::Cuint
    mergereport::Cint
    old_tempstack::Ptr{setT}
    ridgeoutnum::Cint
    last_random::Cint
    rbox_errexit::jmp_buf
    jmpXtra3::NTuple{40, Cchar}
    rbox_isinteger::Cint
    rbox_out_offset::Cdouble
    cpp_object::Ptr{Cvoid}
    cpp_other::Ptr{Cvoid}
    cpp_user::Ptr{Cvoid}
    qhmem::qhmemT
    qhstat::qhstatT
end

function Base.getproperty(x::qhT, f::Symbol)
    f === :fin && return Ptr{Libc.FILE}(getfield(x, f))
    f === :fout && return Ptr{Libc.FILE}(getfield(x, f))
    f === :ferr && return Ptr{Libc.FILE}(getfield(x, f))
    f === :tracevertex && return Ptr{vertexT}(getfield(x, f))
    f === :vertex_list && return Ptr{vertexT}(getfield(x, f))
    f === :vertex_tail && return Ptr{vertexT}(getfield(x, f))
    f === :newvertex_list && return Ptr{vertexT}(getfield(x, f))
    return getfield(x, f)
end

function Base.getproperty(x::Ptr{qhT}, f::Symbol)
    f === :ALLpoints && return Ptr{Cuint}(x + 0)
    f === :ALLOWshort && return Ptr{Cuint}(x + 4)
    f === :ALLOWwarning && return Ptr{Cuint}(x + 8)
    f === :ALLOWwide && return Ptr{Cuint}(x + 12)
    f === :ANGLEmerge && return Ptr{Cuint}(x + 16)
    f === :APPROXhull && return Ptr{Cuint}(x + 20)
    f === :MINoutside && return Ptr{Cdouble}(x + 24)
    f === :ANNOTATEoutput && return Ptr{Cuint}(x + 32)
    f === :ATinfinity && return Ptr{Cuint}(x + 36)
    f === :AVOIDold && return Ptr{Cuint}(x + 40)
    f === :BESToutside && return Ptr{Cuint}(x + 44)
    f === :CDDinput && return Ptr{Cuint}(x + 48)
    f === :CDDoutput && return Ptr{Cuint}(x + 52)
    f === :CHECKduplicates && return Ptr{Cuint}(x + 56)
    f === :CHECKfrequently && return Ptr{Cuint}(x + 60)
    f === :premerge_cos && return Ptr{Cdouble}(x + 64)
    f === :postmerge_cos && return Ptr{Cdouble}(x + 72)
    f === :DELAUNAY && return Ptr{Cuint}(x + 80)
    f === :DOintersections && return Ptr{Cuint}(x + 84)
    f === :DROPdim && return Ptr{Cint}(x + 88)
    f === :FLUSHprint && return Ptr{Cuint}(x + 92)
    f === :FORCEoutput && return Ptr{Cuint}(x + 96)
    f === :GOODpoint && return Ptr{Cint}(x + 100)
    f === :GOODpointp && return Ptr{Ptr{Cdouble}}(x + 104)
    f === :GOODthreshold && return Ptr{Cuint}(x + 108)
    f === :GOODvertex && return Ptr{Cint}(x + 112)
    f === :GOODvertexp && return Ptr{Ptr{Cdouble}}(x + 116)
    f === :HALFspace && return Ptr{Cuint}(x + 120)
    f === :ISqhullQh && return Ptr{Cuint}(x + 124)
    f === :IStracing && return Ptr{Cint}(x + 128)
    f === :KEEParea && return Ptr{Cint}(x + 132)
    f === :KEEPcoplanar && return Ptr{Cuint}(x + 136)
    f === :KEEPinside && return Ptr{Cuint}(x + 140)
    f === :KEEPmerge && return Ptr{Cint}(x + 144)
    f === :KEEPminArea && return Ptr{Cdouble}(x + 152)
    f === :MAXcoplanar && return Ptr{Cdouble}(x + 160)
    f === :MAXwide && return Ptr{Cint}(x + 168)
    f === :MERGEexact && return Ptr{Cuint}(x + 172)
    f === :MERGEindependent && return Ptr{Cuint}(x + 176)
    f === :MERGING && return Ptr{Cuint}(x + 180)
    f === :premerge_centrum && return Ptr{Cdouble}(x + 184)
    f === :postmerge_centrum && return Ptr{Cdouble}(x + 192)
    f === :MERGEpinched && return Ptr{Cuint}(x + 200)
    f === :MERGEvertices && return Ptr{Cuint}(x + 204)
    f === :MINvisible && return Ptr{Cdouble}(x + 208)
    f === :NOnarrow && return Ptr{Cuint}(x + 216)
    f === :NOnearinside && return Ptr{Cuint}(x + 220)
    f === :NOpremerge && return Ptr{Cuint}(x + 224)
    f === :ONLYgood && return Ptr{Cuint}(x + 228)
    f === :ONLYmax && return Ptr{Cuint}(x + 232)
    f === :PICKfurthest && return Ptr{Cuint}(x + 236)
    f === :POSTmerge && return Ptr{Cuint}(x + 240)
    f === :PREmerge && return Ptr{Cuint}(x + 244)
    f === :PRINTcentrums && return Ptr{Cuint}(x + 248)
    f === :PRINTcoplanar && return Ptr{Cuint}(x + 252)
    f === :PRINTdim && return Ptr{Cint}(x + 256)
    f === :PRINTdots && return Ptr{Cuint}(x + 260)
    f === :PRINTgood && return Ptr{Cuint}(x + 264)
    f === :PRINTinner && return Ptr{Cuint}(x + 268)
    f === :PRINTneighbors && return Ptr{Cuint}(x + 272)
    f === :PRINTnoplanes && return Ptr{Cuint}(x + 276)
    f === :PRINToptions1st && return Ptr{Cuint}(x + 280)
    f === :PRINTouter && return Ptr{Cuint}(x + 284)
    f === :PRINTprecision && return Ptr{Cuint}(x + 288)
    f === :PRINTout && return Ptr{NTuple{29, qh_PRINT}}(x + 292)
    f === :PRINTridges && return Ptr{Cuint}(x + 408)
    f === :PRINTspheres && return Ptr{Cuint}(x + 412)
    f === :PRINTstatistics && return Ptr{Cuint}(x + 416)
    f === :PRINTsummary && return Ptr{Cuint}(x + 420)
    f === :PRINTtransparent && return Ptr{Cuint}(x + 424)
    f === :PROJECTdelaunay && return Ptr{Cuint}(x + 428)
    f === :PROJECTinput && return Ptr{Cint}(x + 432)
    f === :RANDOMdist && return Ptr{Cuint}(x + 436)
    f === :RANDOMfactor && return Ptr{Cdouble}(x + 440)
    f === :RANDOMa && return Ptr{Cdouble}(x + 448)
    f === :RANDOMb && return Ptr{Cdouble}(x + 456)
    f === :RANDOMoutside && return Ptr{Cuint}(x + 464)
    f === :REPORTfreq && return Ptr{Cint}(x + 468)
    f === :REPORTfreq2 && return Ptr{Cint}(x + 472)
    f === :RERUN && return Ptr{Cint}(x + 476)
    f === :ROTATErandom && return Ptr{Cint}(x + 480)
    f === :SCALEinput && return Ptr{Cuint}(x + 484)
    f === :SCALElast && return Ptr{Cuint}(x + 488)
    f === :SETroundoff && return Ptr{Cuint}(x + 492)
    f === :SKIPcheckmax && return Ptr{Cuint}(x + 496)
    f === :SKIPconvex && return Ptr{Cuint}(x + 500)
    f === :SPLITthresholds && return Ptr{Cuint}(x + 504)
    f === :STOPadd && return Ptr{Cint}(x + 508)
    f === :STOPcone && return Ptr{Cint}(x + 512)
    f === :STOPpoint && return Ptr{Cint}(x + 516)
    f === :TESTpoints && return Ptr{Cint}(x + 520)
    f === :TESTvneighbors && return Ptr{Cuint}(x + 524)
    f === :TRACElevel && return Ptr{Cint}(x + 528)
    f === :TRACElastrun && return Ptr{Cint}(x + 532)
    f === :TRACEpoint && return Ptr{Cint}(x + 536)
    f === :TRACEdist && return Ptr{Cdouble}(x + 544)
    f === :TRACEmerge && return Ptr{Cint}(x + 552)
    f === :TRIangulate && return Ptr{Cuint}(x + 556)
    f === :TRInormals && return Ptr{Cuint}(x + 560)
    f === :UPPERdelaunay && return Ptr{Cuint}(x + 564)
    f === :USEstdout && return Ptr{Cuint}(x + 568)
    f === :VERIFYoutput && return Ptr{Cuint}(x + 572)
    f === :VIRTUALmemory && return Ptr{Cuint}(x + 576)
    f === :VORONOI && return Ptr{Cuint}(x + 580)
    f === :AREAfactor && return Ptr{Cdouble}(x + 584)
    f === :DOcheckmax && return Ptr{Cuint}(x + 592)
    f === :feasible_string && return Ptr{Ptr{Cchar}}(x + 596)
    f === :feasible_point && return Ptr{Ptr{Cdouble}}(x + 600)
    f === :GETarea && return Ptr{Cuint}(x + 604)
    f === :KEEPnearinside && return Ptr{Cuint}(x + 608)
    f === :hull_dim && return Ptr{Cint}(x + 612)
    f === :input_dim && return Ptr{Cint}(x + 616)
    f === :num_points && return Ptr{Cint}(x + 620)
    f === :first_point && return Ptr{Ptr{Cdouble}}(x + 624)
    f === :POINTSmalloc && return Ptr{Cuint}(x + 628)
    f === :input_points && return Ptr{Ptr{Cdouble}}(x + 632)
    f === :input_malloc && return Ptr{Cuint}(x + 636)
    f === :qhull_command && return Ptr{NTuple{256, Cchar}}(x + 640)
    f === :qhull_commandsiz2 && return Ptr{Cint}(x + 896)
    f === :rbox_command && return Ptr{NTuple{256, Cchar}}(x + 900)
    f === :qhull_options && return Ptr{NTuple{512, Cchar}}(x + 1156)
    f === :qhull_optionlen && return Ptr{Cint}(x + 1668)
    f === :qhull_optionsiz && return Ptr{Cint}(x + 1672)
    f === :qhull_optionsiz2 && return Ptr{Cint}(x + 1676)
    f === :run_id && return Ptr{Cint}(x + 1680)
    f === :VERTEXneighbors && return Ptr{Cuint}(x + 1684)
    f === :ZEROcentrum && return Ptr{Cuint}(x + 1688)
    f === :upper_threshold && return Ptr{Ptr{Cdouble}}(x + 1692)
    f === :lower_threshold && return Ptr{Ptr{Cdouble}}(x + 1696)
    f === :upper_bound && return Ptr{Ptr{Cdouble}}(x + 1700)
    f === :lower_bound && return Ptr{Ptr{Cdouble}}(x + 1704)
    f === :ANGLEround && return Ptr{Cdouble}(x + 1712)
    f === :centrum_radius && return Ptr{Cdouble}(x + 1720)
    f === :cos_max && return Ptr{Cdouble}(x + 1728)
    f === :DISTround && return Ptr{Cdouble}(x + 1736)
    f === :MAXabs_coord && return Ptr{Cdouble}(x + 1744)
    f === :MAXlastcoord && return Ptr{Cdouble}(x + 1752)
    f === :MAXoutside && return Ptr{Cdouble}(x + 1760)
    f === :MAXsumcoord && return Ptr{Cdouble}(x + 1768)
    f === :MAXwidth && return Ptr{Cdouble}(x + 1776)
    f === :MINdenom_1 && return Ptr{Cdouble}(x + 1784)
    f === :MINdenom && return Ptr{Cdouble}(x + 1792)
    f === :MINdenom_1_2 && return Ptr{Cdouble}(x + 1800)
    f === :MINdenom_2 && return Ptr{Cdouble}(x + 1808)
    f === :MINlastcoord && return Ptr{Cdouble}(x + 1816)
    f === :NEARzero && return Ptr{Ptr{Cdouble}}(x + 1824)
    f === :NEARinside && return Ptr{Cdouble}(x + 1832)
    f === :ONEmerge && return Ptr{Cdouble}(x + 1840)
    f === :outside_err && return Ptr{Cdouble}(x + 1848)
    f === :WIDEfacet && return Ptr{Cdouble}(x + 1856)
    f === :NARROWhull && return Ptr{Cuint}(x + 1864)
    f === :qhull && return Ptr{NTuple{6, Cchar}}(x + 1868)
    f === :errexit && return Ptr{jmp_buf}(x + 1880)
    f === :jmpXtra && return Ptr{NTuple{40, Cchar}}(x + 2272)
    f === :restartexit && return Ptr{jmp_buf}(x + 2312)
    f === :jmpXtra2 && return Ptr{NTuple{40, Cchar}}(x + 2704)
    f === :fin && return Ptr{Ptr{Libc.FILE}}(x + 2744)
    f === :fout && return Ptr{Ptr{Libc.FILE}}(x + 2748)
    f === :ferr && return Ptr{Ptr{Libc.FILE}}(x + 2752)
    f === :interior_point && return Ptr{Ptr{Cdouble}}(x + 2756)
    f === :normal_size && return Ptr{Cint}(x + 2760)
    f === :center_size && return Ptr{Cint}(x + 2764)
    f === :TEMPsize && return Ptr{Cint}(x + 2768)
    f === :facet_list && return Ptr{Ptr{facetT}}(x + 2772)
    f === :facet_tail && return Ptr{Ptr{facetT}}(x + 2776)
    f === :facet_next && return Ptr{Ptr{facetT}}(x + 2780)
    f === :newfacet_list && return Ptr{Ptr{facetT}}(x + 2784)
    f === :visible_list && return Ptr{Ptr{facetT}}(x + 2788)
    f === :num_visible && return Ptr{Cint}(x + 2792)
    f === :tracefacet_id && return Ptr{Cuint}(x + 2796)
    f === :tracefacet && return Ptr{Ptr{facetT}}(x + 2800)
    f === :traceridge_id && return Ptr{Cuint}(x + 2804)
    f === :traceridge && return Ptr{Ptr{ridgeT}}(x + 2808)
    f === :tracevertex_id && return Ptr{Cuint}(x + 2812)
    f === :tracevertex && return Ptr{Ptr{vertexT}}(x + 2816)
    f === :vertex_list && return Ptr{Ptr{vertexT}}(x + 2820)
    f === :vertex_tail && return Ptr{Ptr{vertexT}}(x + 2824)
    f === :newvertex_list && return Ptr{Ptr{vertexT}}(x + 2828)
    f === :num_facets && return Ptr{Cint}(x + 2832)
    f === :num_vertices && return Ptr{Cint}(x + 2836)
    f === :num_outside && return Ptr{Cint}(x + 2840)
    f === :num_good && return Ptr{Cint}(x + 2844)
    f === :facet_id && return Ptr{Cuint}(x + 2848)
    f === :ridge_id && return Ptr{Cuint}(x + 2852)
    f === :vertex_id && return Ptr{Cuint}(x + 2856)
    f === :first_newfacet && return Ptr{Cuint}(x + 2860)
    f === :hulltime && return Ptr{Culong}(x + 2864)
    f === :ALLOWrestart && return Ptr{Cuint}(x + 2868)
    f === :build_cnt && return Ptr{Cint}(x + 2872)
    f === :CENTERtype && return Ptr{qh_CENTER}(x + 2876)
    f === :furthest_id && return Ptr{Cint}(x + 2880)
    f === :last_errcode && return Ptr{Cint}(x + 2884)
    f === :GOODclosest && return Ptr{Ptr{facetT}}(x + 2888)
    f === :coplanar_apex && return Ptr{Ptr{Cdouble}}(x + 2892)
    f === :hasAreaVolume && return Ptr{Cuint}(x + 2896)
    f === :hasTriangulation && return Ptr{Cuint}(x + 2900)
    f === :isRenameVertex && return Ptr{Cuint}(x + 2904)
    f === :JOGGLEmax && return Ptr{Cdouble}(x + 2912)
    f === :maxoutdone && return Ptr{Cuint}(x + 2920)
    f === :max_outside && return Ptr{Cdouble}(x + 2928)
    f === :max_vertex && return Ptr{Cdouble}(x + 2936)
    f === :min_vertex && return Ptr{Cdouble}(x + 2944)
    f === :NEWfacets && return Ptr{Cuint}(x + 2952)
    f === :NEWtentative && return Ptr{Cuint}(x + 2956)
    f === :findbestnew && return Ptr{Cuint}(x + 2960)
    f === :findbest_notsharp && return Ptr{Cuint}(x + 2964)
    f === :NOerrexit && return Ptr{Cuint}(x + 2968)
    f === :PRINTcradius && return Ptr{Cdouble}(x + 2976)
    f === :PRINTradius && return Ptr{Cdouble}(x + 2984)
    f === :POSTmerging && return Ptr{Cuint}(x + 2992)
    f === :printoutvar && return Ptr{Cint}(x + 2996)
    f === :printoutnum && return Ptr{Cint}(x + 3000)
    f === :repart_facetid && return Ptr{Cuint}(x + 3004)
    f === :retry_addpoint && return Ptr{Cint}(x + 3008)
    f === :QHULLfinished && return Ptr{Cuint}(x + 3012)
    f === :totarea && return Ptr{Cdouble}(x + 3016)
    f === :totvol && return Ptr{Cdouble}(x + 3024)
    f === :visit_id && return Ptr{Cuint}(x + 3032)
    f === :vertex_visit && return Ptr{Cuint}(x + 3036)
    f === :WAScoplanar && return Ptr{Cuint}(x + 3040)
    f === :ZEROall_ok && return Ptr{Cuint}(x + 3044)
    f === :facet_mergeset && return Ptr{Ptr{setT}}(x + 3048)
    f === :degen_mergeset && return Ptr{Ptr{setT}}(x + 3052)
    f === :vertex_mergeset && return Ptr{Ptr{setT}}(x + 3056)
    f === :hash_table && return Ptr{Ptr{setT}}(x + 3060)
    f === :other_points && return Ptr{Ptr{setT}}(x + 3064)
    f === :del_vertices && return Ptr{Ptr{setT}}(x + 3068)
    f === :gm_matrix && return Ptr{Ptr{Cdouble}}(x + 3072)
    f === :gm_row && return Ptr{Ptr{Ptr{Cdouble}}}(x + 3076)
    f === :line && return Ptr{Ptr{Cchar}}(x + 3080)
    f === :maxline && return Ptr{Cint}(x + 3084)
    f === :half_space && return Ptr{Ptr{Cdouble}}(x + 3088)
    f === :temp_malloc && return Ptr{Ptr{Cdouble}}(x + 3092)
    f === :ERREXITcalled && return Ptr{Cuint}(x + 3096)
    f === :firstcentrum && return Ptr{Cuint}(x + 3100)
    f === :old_randomdist && return Ptr{Cuint}(x + 3104)
    f === :coplanarfacetset && return Ptr{Ptr{setT}}(x + 3108)
    f === :last_low && return Ptr{Cdouble}(x + 3112)
    f === :last_high && return Ptr{Cdouble}(x + 3120)
    f === :last_newhigh && return Ptr{Cdouble}(x + 3128)
    f === :lastcpu && return Ptr{Cdouble}(x + 3136)
    f === :lastfacets && return Ptr{Cint}(x + 3144)
    f === :lastmerges && return Ptr{Cint}(x + 3148)
    f === :lastplanes && return Ptr{Cint}(x + 3152)
    f === :lastdist && return Ptr{Cint}(x + 3156)
    f === :lastreport && return Ptr{Cuint}(x + 3160)
    f === :mergereport && return Ptr{Cint}(x + 3164)
    f === :old_tempstack && return Ptr{Ptr{setT}}(x + 3168)
    f === :ridgeoutnum && return Ptr{Cint}(x + 3172)
    f === :last_random && return Ptr{Cint}(x + 3176)
    f === :rbox_errexit && return Ptr{jmp_buf}(x + 3184)
    f === :jmpXtra3 && return Ptr{NTuple{40, Cchar}}(x + 3576)
    f === :rbox_isinteger && return Ptr{Cint}(x + 3616)
    f === :rbox_out_offset && return Ptr{Cdouble}(x + 3624)
    f === :cpp_object && return Ptr{Ptr{Cvoid}}(x + 3632)
    f === :cpp_other && return Ptr{Ptr{Cvoid}}(x + 3636)
    f === :cpp_user && return Ptr{Ptr{Cvoid}}(x + 3640)
    f === :qhmem && return Ptr{qhmemT}(x + 3644)
    f === :qhstat && return Ptr{qhstatT}(x + 3760)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{qhT}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const ptr_intT = Clong

function qh_memalloc(qh, insize)
    ccall((:qh_memalloc, libqhull_r), Ptr{Cvoid}, (Ptr{qhT}, Cint), qh, insize)
end

function qh_memcheck(qh)
    ccall((:qh_memcheck, libqhull_r), Cvoid, (Ptr{qhT},), qh)
end

function qh_memfree(qh, object, insize)
    ccall((:qh_memfree, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Cvoid}, Cint), qh, object, insize)
end

function qh_memfreeshort(qh, curlong, totlong)
    ccall((:qh_memfreeshort, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Cint}, Ptr{Cint}), qh, curlong, totlong)
end

function qh_meminit(qh, ferr)
    ccall((:qh_meminit, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Libc.FILE}), qh, ferr)
end

function qh_meminitbuffers(qh, tracelevel, alignment, numsizes, bufsize, bufinit)
    ccall((:qh_meminitbuffers, libqhull_r), Cvoid, (Ptr{qhT}, Cint, Cint, Cint, Cint, Cint), qh, tracelevel, alignment, numsizes, bufsize, bufinit)
end

function qh_memsetup(qh)
    ccall((:qh_memsetup, libqhull_r), Cvoid, (Ptr{qhT},), qh)
end

function qh_memsize(qh, size)
    ccall((:qh_memsize, libqhull_r), Cvoid, (Ptr{qhT}, Cint), qh, size)
end

function qh_memstatistics(qh, fp)
    ccall((:qh_memstatistics, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Libc.FILE}), qh, fp)
end

function qh_memtotal(qh, totlong, curlong, totshort, curshort, maxlong, totbuffer)
    ccall((:qh_memtotal, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), qh, totlong, curlong, totshort, curshort, maxlong, totbuffer)
end

function qh_setaddsorted(qh, setp, elem)
    ccall((:qh_setaddsorted, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Ptr{setT}}, Ptr{Cvoid}), qh, setp, elem)
end

function qh_setaddnth(qh, setp, nth, newelem)
    ccall((:qh_setaddnth, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Ptr{setT}}, Cint, Ptr{Cvoid}), qh, setp, nth, newelem)
end

function qh_setappend(qh, setp, elem)
    ccall((:qh_setappend, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Ptr{setT}}, Ptr{Cvoid}), qh, setp, elem)
end

function qh_setappend_set(qh, setp, setA)
    ccall((:qh_setappend_set, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Ptr{setT}}, Ptr{setT}), qh, setp, setA)
end

function qh_setappend2ndlast(qh, setp, elem)
    ccall((:qh_setappend2ndlast, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Ptr{setT}}, Ptr{Cvoid}), qh, setp, elem)
end

function qh_setcheck(qh, set, tname, id)
    ccall((:qh_setcheck, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{setT}, Ptr{Cchar}, Cuint), qh, set, tname, id)
end

function qh_setcompact(qh, set)
    ccall((:qh_setcompact, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{setT}), qh, set)
end

function qh_setcopy(qh, set, extra)
    ccall((:qh_setcopy, libqhull_r), Ptr{setT}, (Ptr{qhT}, Ptr{setT}, Cint), qh, set, extra)
end

function qh_setdel(set, elem)
    ccall((:qh_setdel, libqhull_r), Ptr{Cvoid}, (Ptr{setT}, Ptr{Cvoid}), set, elem)
end

function qh_setdellast(set)
    ccall((:qh_setdellast, libqhull_r), Ptr{Cvoid}, (Ptr{setT},), set)
end

function qh_setdelnth(qh, set, nth)
    ccall((:qh_setdelnth, libqhull_r), Ptr{Cvoid}, (Ptr{qhT}, Ptr{setT}, Cint), qh, set, nth)
end

function qh_setdelnthsorted(qh, set, nth)
    ccall((:qh_setdelnthsorted, libqhull_r), Ptr{Cvoid}, (Ptr{qhT}, Ptr{setT}, Cint), qh, set, nth)
end

function qh_setdelsorted(set, newelem)
    ccall((:qh_setdelsorted, libqhull_r), Ptr{Cvoid}, (Ptr{setT}, Ptr{Cvoid}), set, newelem)
end

function qh_setduplicate(qh, set, elemsize)
    ccall((:qh_setduplicate, libqhull_r), Ptr{setT}, (Ptr{qhT}, Ptr{setT}, Cint), qh, set, elemsize)
end

function qh_setendpointer(set)
    ccall((:qh_setendpointer, libqhull_r), Ptr{Ptr{Cvoid}}, (Ptr{setT},), set)
end

function qh_setequal(setA, setB)
    ccall((:qh_setequal, libqhull_r), Cint, (Ptr{setT}, Ptr{setT}), setA, setB)
end

function qh_setequal_except(setA, skipelemA, setB, skipelemB)
    ccall((:qh_setequal_except, libqhull_r), Cint, (Ptr{setT}, Ptr{Cvoid}, Ptr{setT}, Ptr{Cvoid}), setA, skipelemA, setB, skipelemB)
end

function qh_setequal_skip(setA, skipA, setB, skipB)
    ccall((:qh_setequal_skip, libqhull_r), Cint, (Ptr{setT}, Cint, Ptr{setT}, Cint), setA, skipA, setB, skipB)
end

function qh_setfree(qh, set)
    ccall((:qh_setfree, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Ptr{setT}}), qh, set)
end

function qh_setfree2(qh, setp, elemsize)
    ccall((:qh_setfree2, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Ptr{setT}}, Cint), qh, setp, elemsize)
end

function qh_setfreelong(qh, set)
    ccall((:qh_setfreelong, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Ptr{setT}}), qh, set)
end

function qh_setin(set, setelem)
    ccall((:qh_setin, libqhull_r), Cint, (Ptr{setT}, Ptr{Cvoid}), set, setelem)
end

function qh_setindex(set, setelem)
    ccall((:qh_setindex, libqhull_r), Cint, (Ptr{setT}, Ptr{Cvoid}), set, setelem)
end

function qh_setlarger(qh, setp)
    ccall((:qh_setlarger, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Ptr{setT}}), qh, setp)
end

function qh_setlarger_quick(qh, setsize, newsize)
    ccall((:qh_setlarger_quick, libqhull_r), Cint, (Ptr{qhT}, Cint, Ptr{Cint}), qh, setsize, newsize)
end

function qh_setlast(set)
    ccall((:qh_setlast, libqhull_r), Ptr{Cvoid}, (Ptr{setT},), set)
end

function qh_setnew(qh, size)
    ccall((:qh_setnew, libqhull_r), Ptr{setT}, (Ptr{qhT}, Cint), qh, size)
end

function qh_setnew_delnthsorted(qh, set, size, nth, prepend)
    ccall((:qh_setnew_delnthsorted, libqhull_r), Ptr{setT}, (Ptr{qhT}, Ptr{setT}, Cint, Cint, Cint), qh, set, size, nth, prepend)
end

function qh_setprint(qh, fp, string, set)
    ccall((:qh_setprint, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Libc.FILE}, Ptr{Cchar}, Ptr{setT}), qh, fp, string, set)
end

function qh_setreplace(qh, set, oldelem, newelem)
    ccall((:qh_setreplace, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{setT}, Ptr{Cvoid}, Ptr{Cvoid}), qh, set, oldelem, newelem)
end

function qh_setsize(qh, set)
    ccall((:qh_setsize, libqhull_r), Cint, (Ptr{qhT}, Ptr{setT}), qh, set)
end

function qh_settemp(qh, setsize)
    ccall((:qh_settemp, libqhull_r), Ptr{setT}, (Ptr{qhT}, Cint), qh, setsize)
end

function qh_settempfree(qh, set)
    ccall((:qh_settempfree, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Ptr{setT}}), qh, set)
end

function qh_settempfree_all(qh)
    ccall((:qh_settempfree_all, libqhull_r), Cvoid, (Ptr{qhT},), qh)
end

function qh_settemppop(qh)
    ccall((:qh_settemppop, libqhull_r), Ptr{setT}, (Ptr{qhT},), qh)
end

function qh_settemppush(qh, set)
    ccall((:qh_settemppush, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{setT}), qh, set)
end

function qh_settruncate(qh, set, size)
    ccall((:qh_settruncate, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{setT}, Cint), qh, set, size)
end

function qh_setunique(qh, set, elem)
    ccall((:qh_setunique, libqhull_r), Cint, (Ptr{qhT}, Ptr{Ptr{setT}}, Ptr{Cvoid}), qh, set, elem)
end

function qh_setzero(qh, set, idx, size)
    ccall((:qh_setzero, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{setT}, Cint, Cint), qh, set, idx, size)
end

@enum qh_pointT::Int32 begin
    qh_IDnone = -3
    qh_IDinterior = -2
    qh_IDunknown = -1
end

@enum qh_statistics::UInt32 begin
    Zacoplanar = 0
    Wacoplanarmax = 1
    Wacoplanartot = 2
    Zangle = 3
    Wangle = 4
    Wanglemax = 5
    Wanglemin = 6
    Zangletests = 7
    Wareatot = 8
    Wareamax = 9
    Wareamin = 10
    Zavoidold = 11
    Wavoidoldmax = 12
    Wavoidoldtot = 13
    Zback0 = 14
    Zbestcentrum = 15
    Zbestdist = 16
    Zbestlower = 17
    Zbestlowerall = 18
    Zbestloweralln = 19
    Zbestlowerv = 20
    Zcentrumtests = 21
    Zcheckpart = 22
    Zcomputefurthest = 23
    Zconcave = 24
    Wconcavemax = 25
    Wconcavetot = 26
    Zconcavecoplanar = 27
    Wconcavecoplanarmax = 28
    Wconcavecoplanartot = 29
    Zconcavecoplanarridge = 30
    Zconcaveridge = 31
    Zconcaveridges = 32
    Zcoplanar = 33
    Wcoplanarmax = 34
    Wcoplanartot = 35
    Zcoplanarangle = 36
    Zcoplanarcentrum = 37
    Zcoplanarhorizon = 38
    Zcoplanarinside = 39
    Zcoplanarpart = 40
    Zcoplanarridges = 41
    Wcpu = 42
    Zcyclefacetmax = 43
    Zcyclefacettot = 44
    Zcyclehorizon = 45
    Zcyclevertex = 46
    Zdegen = 47
    Wdegenmax = 48
    Wdegentot = 49
    Zdegenvertex = 50
    Zdelfacetdup = 51
    Zdelridge = 52
    Zdelvertextot = 53
    Zdelvertexmax = 54
    Zdetfacetarea = 55
    Zdetsimplex = 56
    Zdistcheck = 57
    Zdistconvex = 58
    Zdistgood = 59
    Zdistio = 60
    Zdistplane = 61
    Zdiststat = 62
    Zdistvertex = 63
    Zdistzero = 64
    Zdoc1 = 65
    Zdoc2 = 66
    Zdoc3 = 67
    Zdoc4 = 68
    Zdoc5 = 69
    Zdoc6 = 70
    Zdoc7 = 71
    Zdoc8 = 72
    Zdoc9 = 73
    Zdoc10 = 74
    Zdoc11 = 75
    Zdoc12 = 76
    Zdropdegen = 77
    Zdropneighbor = 78
    Zdupflip = 79
    Zduplicate = 80
    Wduplicatemax = 81
    Wduplicatetot = 82
    Zdupsame = 83
    Zflipped = 84
    Wflippedmax = 85
    Wflippedtot = 86
    Zflippedfacets = 87
    Zflipridge = 88
    Zflipridge2 = 89
    Zfindbest = 90
    Zfindbestmax = 91
    Zfindbesttot = 92
    Zfindcoplanar = 93
    Zfindfail = 94
    Zfindhorizon = 95
    Zfindhorizonmax = 96
    Zfindhorizontot = 97
    Zfindjump = 98
    Zfindnew = 99
    Zfindnewmax = 100
    Zfindnewtot = 101
    Zfindnewjump = 102
    Zfindnewsharp = 103
    Zgauss0 = 104
    Zgoodfacet = 105
    Zhashlookup = 106
    Zhashridge = 107
    Zhashridgetest = 108
    Zhashtests = 109
    Zinsidevisible = 110
    Zintersect = 111
    Zintersectfail = 112
    Zintersectmax = 113
    Zintersectnum = 114
    Zintersecttot = 115
    Zmaxneighbors = 116
    Wmaxout = 117
    Wmaxoutside = 118
    Zmaxridges = 119
    Zmaxvertex = 120
    Zmaxvertices = 121
    Zmaxvneighbors = 122
    Zmemfacets = 123
    Zmempoints = 124
    Zmemridges = 125
    Zmemvertices = 126
    Zmergeflipdup = 127
    Zmergehorizon = 128
    Zmergeinittot = 129
    Zmergeinitmax = 130
    Zmergeinittot2 = 131
    Zmergeintocoplanar = 132
    Zmergeintohorizon = 133
    Zmergenew = 134
    Zmergesettot = 135
    Zmergesetmax = 136
    Zmergesettot2 = 137
    Zmergesimplex = 138
    Zmergevertex = 139
    Wmindenom = 140
    Wminvertex = 141
    Zminnorm = 142
    Zmultiridge = 143
    Znearlysingular = 144
    Zredundant = 145
    Wnewbalance = 146
    Wnewbalance2 = 147
    Znewbesthorizon = 148
    Znewfacettot = 149
    Znewfacetmax = 150
    Znewvertex = 151
    Wnewvertex = 152
    Wnewvertexmax = 153
    Znewvertexridge = 154
    Znoarea = 155
    Znonsimplicial = 156
    Znowsimplicial = 157
    Znotgood = 158
    Znotgoodnew = 159
    Znotmax = 160
    Znumfacets = 161
    Znummergemax = 162
    Znummergetot = 163
    Znumneighbors = 164
    Znumridges = 165
    Znumvertices = 166
    Znumvisibility = 167
    Znumvneighbors = 168
    Zonehorizon = 169
    Zpartangle = 170
    Zpartcoplanar = 171
    Zpartcorner = 172
    Zparthidden = 173
    Zpartinside = 174
    Zpartition = 175
    Zpartitionall = 176
    Zpartnear = 177
    Zparttwisted = 178
    Zpbalance = 179
    Wpbalance = 180
    Wpbalance2 = 181
    Zpinchduplicate = 182
    Zpinchedapex = 183
    Zpinchedvertex = 184
    Zpostfacets = 185
    Zpremergetot = 186
    Zprocessed = 187
    Zremvertex = 188
    Zremvertexdel = 189
    Zredundantmerge = 190
    Zrenameall = 191
    Zrenamepinch = 192
    Zrenameshare = 193
    Zretry = 194
    Wretrymax = 195
    Zretryadd = 196
    Zretryaddmax = 197
    Zretryaddtot = 198
    Zridge = 199
    Wridge = 200
    Wridgemax = 201
    Zridge0 = 202
    Wridge0 = 203
    Wridge0max = 204
    Zridgemid = 205
    Wridgemid = 206
    Wridgemidmax = 207
    Zridgeok = 208
    Wridgeok = 209
    Wridgeokmax = 210
    Zsearchpoints = 211
    Zsetplane = 212
    Ztestvneighbor = 213
    Ztotcheck = 214
    Ztothorizon = 215
    Ztotmerge = 216
    Ztotpartcoplanar = 217
    Ztotpartition = 218
    Ztotridges = 219
    Ztotvertices = 220
    Ztotvisible = 221
    Ztricoplanar = 222
    Ztricoplanarmax = 223
    Ztricoplanartot = 224
    Ztridegen = 225
    Ztrimirror = 226
    Ztrinull = 227
    Ztwisted = 228
    Wtwistedtot = 229
    Wtwistedmax = 230
    Ztwistedridge = 231
    Zvertextests = 232
    Wvertexmax = 233
    Wvertexmin = 234
    Zvertexridge = 235
    Zvertexridgetot = 236
    Zvertexridgemax = 237
    Zvertices = 238
    Zvisfacettot = 239
    Zvisfacetmax = 240
    Zvisit = 241
    Zvisit2max = 242
    Zvisvertextot = 243
    Zvisvertexmax = 244
    Zvvisit = 245
    Zvvisit2max = 246
    Zwidefacet = 247
    Zwidevertices = 248
    ZEND = 249
end

@enum ztypes::UInt32 begin
    zdoc = 0
    zinc = 1
    zadd = 2
    zmax = 3
    zmin = 4
    ZTYPEreal = 5
    wadd = 6
    wmax = 7
    wmin = 8
    ZTYPEend = 9
end

function qh_allstatA(qh)
    ccall((:qh_allstatA, libqhull_r), Cvoid, (Ptr{qhT},), qh)
end

function qh_allstatB(qh)
    ccall((:qh_allstatB, libqhull_r), Cvoid, (Ptr{qhT},), qh)
end

function qh_allstatC(qh)
    ccall((:qh_allstatC, libqhull_r), Cvoid, (Ptr{qhT},), qh)
end

function qh_allstatD(qh)
    ccall((:qh_allstatD, libqhull_r), Cvoid, (Ptr{qhT},), qh)
end

function qh_allstatE(qh)
    ccall((:qh_allstatE, libqhull_r), Cvoid, (Ptr{qhT},), qh)
end

function qh_allstatE2(qh)
    ccall((:qh_allstatE2, libqhull_r), Cvoid, (Ptr{qhT},), qh)
end

function qh_allstatF(qh)
    ccall((:qh_allstatF, libqhull_r), Cvoid, (Ptr{qhT},), qh)
end

function qh_allstatG(qh)
    ccall((:qh_allstatG, libqhull_r), Cvoid, (Ptr{qhT},), qh)
end

function qh_allstatH(qh)
    ccall((:qh_allstatH, libqhull_r), Cvoid, (Ptr{qhT},), qh)
end

function qh_allstatI(qh)
    ccall((:qh_allstatI, libqhull_r), Cvoid, (Ptr{qhT},), qh)
end

function qh_allstatistics(qh)
    ccall((:qh_allstatistics, libqhull_r), Cvoid, (Ptr{qhT},), qh)
end

function qh_collectstatistics(qh)
    ccall((:qh_collectstatistics, libqhull_r), Cvoid, (Ptr{qhT},), qh)
end

function qh_initstatistics(qh)
    ccall((:qh_initstatistics, libqhull_r), Cvoid, (Ptr{qhT},), qh)
end

function qh_newstats(qh, idx, nextindex)
    ccall((:qh_newstats, libqhull_r), Cuint, (Ptr{qhT}, Cint, Ptr{Cint}), qh, idx, nextindex)
end

function qh_nostatistic(qh, i)
    ccall((:qh_nostatistic, libqhull_r), Cuint, (Ptr{qhT}, Cint), qh, i)
end

function qh_printallstatistics(qh, fp, string)
    ccall((:qh_printallstatistics, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Libc.FILE}, Ptr{Cchar}), qh, fp, string)
end

function qh_printstatistics(qh, fp, string)
    ccall((:qh_printstatistics, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Libc.FILE}, Ptr{Cchar}), qh, fp, string)
end

function qh_printstatlevel(qh, fp, id)
    ccall((:qh_printstatlevel, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Libc.FILE}, Cint), qh, fp, id)
end

function qh_printstats(qh, fp, idx, nextindex)
    ccall((:qh_printstats, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Libc.FILE}, Cint, Ptr{Cint}), qh, fp, idx, nextindex)
end

function qh_stddev(qh, num, tot, tot2, ave)
    ccall((:qh_stddev, libqhull_r), Cdouble, (Ptr{qhT}, Cint, Cdouble, Cdouble, Ptr{Cdouble}), qh, num, tot, tot2, ave)
end

struct vertexT
    data::NTuple{28, UInt8}
end

function Base.getproperty(x::Ptr{vertexT}, f::Symbol)
    f === :next && return Ptr{Ptr{vertexT}}(x + 0)
    f === :previous && return Ptr{Ptr{vertexT}}(x + 4)
    f === :point && return Ptr{Ptr{Cdouble}}(x + 8)
    f === :neighbors && return Ptr{Ptr{setT}}(x + 12)
    f === :id && return Ptr{Cuint}(x + 16)
    f === :visitid && return Ptr{Cuint}(x + 20)
    f === :seen && return Ptr{Cuint}(x + 24)
    f === :seen2 && return (Ptr{Cuint}(x + 24), 1, 1)
    f === :deleted && return (Ptr{Cuint}(x + 24), 2, 1)
    f === :delridge && return (Ptr{Cuint}(x + 24), 3, 1)
    f === :newfacet && return (Ptr{Cuint}(x + 24), 4, 1)
    f === :partitioned && return (Ptr{Cuint}(x + 24), 5, 1)
    return getfield(x, f)
end

function Base.getproperty(x::vertexT, f::Symbol)
    r = Ref{vertexT}(x)
    ptr = Base.unsafe_convert(Ptr{vertexT}, r)
    fptr = getproperty(ptr, f)
    begin
        if fptr isa Ptr
            return GC.@preserve(r, unsafe_load(fptr))
        else
            (baseptr, offset, width) = fptr
            ty = eltype(baseptr)
            i8 = GC.@preserve(r, unsafe_load(baseptr))
            bitstr = bitstring(i8)
            sig = bitstr[(end - offset) - (width - 1):end - offset]
            zexted = lpad(sig, 8 * sizeof(ty), '0')
            return parse(ty, zexted; base = 2)
        end
    end
end

function Base.setproperty!(x::Ptr{vertexT}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

function qh_qhull(qh)
    ccall((:qh_qhull, libqhull_r), Cvoid, (Ptr{qhT},), qh)
end

function qh_addpoint(qh, furthest, facet, checkdist)
    ccall((:qh_addpoint, libqhull_r), Cuint, (Ptr{qhT}, Ptr{Cdouble}, Ptr{facetT}, Cuint), qh, furthest, facet, checkdist)
end

function qh_errexit2(qh, exitcode, facet, otherfacet)
    ccall((:qh_errexit2, libqhull_r), Cvoid, (Ptr{qhT}, Cint, Ptr{facetT}, Ptr{facetT}), qh, exitcode, facet, otherfacet)
end

function qh_printsummary(qh, fp)
    ccall((:qh_printsummary, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Libc.FILE}), qh, fp)
end

function qh_errexit(qh, exitcode, facet, ridge)
    ccall((:qh_errexit, libqhull_r), Cvoid, (Ptr{qhT}, Cint, Ptr{facetT}, Ptr{ridgeT}), qh, exitcode, facet, ridge)
end

function qh_errprint(qh, string, atfacet, otherfacet, atridge, atvertex)
    ccall((:qh_errprint, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Cchar}, Ptr{facetT}, Ptr{facetT}, Ptr{ridgeT}, Ptr{vertexT}), qh, string, atfacet, otherfacet, atridge, atvertex)
end

function qh_new_qhull(qh, dim, numpoints, points, ismalloc, qhull_cmd, outfile, errfile)
    ccall((:qh_new_qhull, libqhull_r), Cint, (Ptr{qhT}, Cint, Cint, Ptr{Cdouble}, Cuint, Ptr{Cchar}, Ptr{Libc.FILE}, Ptr{Libc.FILE}), qh, dim, numpoints, points, ismalloc, qhull_cmd, outfile, errfile)
end

function qh_printfacetlist(qh, facetlist, facets, printall)
    ccall((:qh_printfacetlist, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{facetT}, Ptr{setT}, Cuint), qh, facetlist, facets, printall)
end

function qh_printhelp_degenerate(qh, fp)
    ccall((:qh_printhelp_degenerate, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Libc.FILE}), qh, fp)
end

function qh_printhelp_internal(qh, fp)
    ccall((:qh_printhelp_internal, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Libc.FILE}), qh, fp)
end

function qh_printhelp_narrowhull(qh, fp, minangle)
    ccall((:qh_printhelp_narrowhull, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Libc.FILE}, Cdouble), qh, fp, minangle)
end

function qh_printhelp_singular(qh, fp)
    ccall((:qh_printhelp_singular, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Libc.FILE}), qh, fp)
end

function qh_printhelp_topology(qh, fp)
    ccall((:qh_printhelp_topology, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Libc.FILE}), qh, fp)
end

function qh_printhelp_wide(qh, fp)
    ccall((:qh_printhelp_wide, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Libc.FILE}), qh, fp)
end

function qh_user_memsizes(qh)
    ccall((:qh_user_memsizes, libqhull_r), Cvoid, (Ptr{qhT},), qh)
end

function qh_exit(exitcode)
    ccall((:qh_exit, libqhull_r), Cvoid, (Cint,), exitcode)
end

function qh_free(mem)
    ccall((:qh_free, libqhull_r), Cvoid, (Ptr{Cvoid},), mem)
end

function qh_malloc(size)
    ccall((:qh_malloc, libqhull_r), Ptr{Cvoid}, (Csize_t,), size)
end

function qh_findbest(qh, point, startfacet, bestoutside, newfacets, noupper, dist, isoutside, numpart)
    ccall((:qh_findbest, libqhull_r), Ptr{facetT}, (Ptr{qhT}, Ptr{Cdouble}, Ptr{facetT}, Cuint, Cuint, Cuint, Ptr{Cdouble}, Ptr{Cuint}, Ptr{Cint}), qh, point, startfacet, bestoutside, newfacets, noupper, dist, isoutside, numpart)
end

function qh_findbestnew(qh, point, startfacet, dist, bestoutside, isoutside, numpart)
    ccall((:qh_findbestnew, libqhull_r), Ptr{facetT}, (Ptr{qhT}, Ptr{Cdouble}, Ptr{facetT}, Ptr{Cdouble}, Cuint, Ptr{Cuint}, Ptr{Cint}), qh, point, startfacet, dist, bestoutside, isoutside, numpart)
end

function qh_gram_schmidt(qh, dim, rows)
    ccall((:qh_gram_schmidt, libqhull_r), Cuint, (Ptr{qhT}, Cint, Ptr{Ptr{Cdouble}}), qh, dim, rows)
end

function qh_outerinner(qh, facet, outerplane, innerplane)
    ccall((:qh_outerinner, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{facetT}, Ptr{Cdouble}, Ptr{Cdouble}), qh, facet, outerplane, innerplane)
end

function qh_projectinput(qh)
    ccall((:qh_projectinput, libqhull_r), Cvoid, (Ptr{qhT},), qh)
end

function qh_randommatrix(qh, buffer, dim, row)
    ccall((:qh_randommatrix, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Cdouble}, Cint, Ptr{Ptr{Cdouble}}), qh, buffer, dim, row)
end

function qh_rotateinput(qh, rows)
    ccall((:qh_rotateinput, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Ptr{Cdouble}}), qh, rows)
end

function qh_scaleinput(qh)
    ccall((:qh_scaleinput, libqhull_r), Cvoid, (Ptr{qhT},), qh)
end

function qh_setdelaunay(qh, dim, count, points)
    ccall((:qh_setdelaunay, libqhull_r), Cvoid, (Ptr{qhT}, Cint, Cint, Ptr{Cdouble}), qh, dim, count, points)
end

function qh_sethalfspace_all(qh, dim, count, halfspaces, feasible)
    ccall((:qh_sethalfspace_all, libqhull_r), Ptr{Cdouble}, (Ptr{qhT}, Cint, Cint, Ptr{Cdouble}, Ptr{Cdouble}), qh, dim, count, halfspaces, feasible)
end

function qh_clock(qh)
    ccall((:qh_clock, libqhull_r), Culong, (Ptr{qhT},), qh)
end

function qh_checkflags(qh, command, hiddenflags)
    ccall((:qh_checkflags, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Cchar}, Ptr{Cchar}), qh, command, hiddenflags)
end

function qh_clear_outputflags(qh)
    ccall((:qh_clear_outputflags, libqhull_r), Cvoid, (Ptr{qhT},), qh)
end

function qh_freebuffers(qh)
    ccall((:qh_freebuffers, libqhull_r), Cvoid, (Ptr{qhT},), qh)
end

function qh_freeqhull(qh, allmem)
    ccall((:qh_freeqhull, libqhull_r), Cvoid, (Ptr{qhT}, Cuint), qh, allmem)
end

function qh_init_A(qh, infile, outfile, errfile, argc, argv)
    ccall((:qh_init_A, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Libc.FILE}, Ptr{Libc.FILE}, Ptr{Libc.FILE}, Cint, Ptr{Ptr{Cchar}}), qh, infile, outfile, errfile, argc, argv)
end

function qh_init_B(qh, points, numpoints, dim, ismalloc)
    ccall((:qh_init_B, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Cdouble}, Cint, Cint, Cuint), qh, points, numpoints, dim, ismalloc)
end

function qh_init_qhull_command(qh, argc, argv)
    ccall((:qh_init_qhull_command, libqhull_r), Cvoid, (Ptr{qhT}, Cint, Ptr{Ptr{Cchar}}), qh, argc, argv)
end

function qh_initbuffers(qh, points, numpoints, dim, ismalloc)
    ccall((:qh_initbuffers, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Cdouble}, Cint, Cint, Cuint), qh, points, numpoints, dim, ismalloc)
end

function qh_initflags(qh, command)
    ccall((:qh_initflags, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Cchar}), qh, command)
end

function qh_initqhull_buffers(qh)
    ccall((:qh_initqhull_buffers, libqhull_r), Cvoid, (Ptr{qhT},), qh)
end

function qh_initqhull_globals(qh, points, numpoints, dim, ismalloc)
    ccall((:qh_initqhull_globals, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Cdouble}, Cint, Cint, Cuint), qh, points, numpoints, dim, ismalloc)
end

function qh_initqhull_mem(qh)
    ccall((:qh_initqhull_mem, libqhull_r), Cvoid, (Ptr{qhT},), qh)
end

function qh_initqhull_outputflags(qh)
    ccall((:qh_initqhull_outputflags, libqhull_r), Cvoid, (Ptr{qhT},), qh)
end

function qh_initqhull_start(qh, infile, outfile, errfile)
    ccall((:qh_initqhull_start, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Libc.FILE}, Ptr{Libc.FILE}, Ptr{Libc.FILE}), qh, infile, outfile, errfile)
end

function qh_initqhull_start2(qh, infile, outfile, errfile)
    ccall((:qh_initqhull_start2, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Libc.FILE}, Ptr{Libc.FILE}, Ptr{Libc.FILE}), qh, infile, outfile, errfile)
end

function qh_initthresholds(qh, command)
    ccall((:qh_initthresholds, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Cchar}), qh, command)
end

function qh_lib_check(qhullLibraryType, qhTsize, vertexTsize, ridgeTsize, facetTsize, setTsize, qhmemTsize)
    ccall((:qh_lib_check, libqhull_r), Cvoid, (Cint, Cint, Cint, Cint, Cint, Cint, Cint), qhullLibraryType, qhTsize, vertexTsize, ridgeTsize, facetTsize, setTsize, qhmemTsize)
end

function qh_option(qh, option, i, r)
    ccall((:qh_option, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Cchar}, Ptr{Cint}, Ptr{Cdouble}), qh, option, i, r)
end

function qh_zero(qh, errfile)
    ccall((:qh_zero, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Libc.FILE}), qh, errfile)
end

function qh_dfacet(qh, id)
    ccall((:qh_dfacet, libqhull_r), Cvoid, (Ptr{qhT}, Cuint), qh, id)
end

function qh_dvertex(qh, id)
    ccall((:qh_dvertex, libqhull_r), Cvoid, (Ptr{qhT}, Cuint), qh, id)
end

function qh_printneighborhood(qh, fp, format, facetA, facetB, printall)
    ccall((:qh_printneighborhood, libqhull_r), Cvoid, (Ptr{qhT}, Ptr{Libc.FILE}, qh_PRINT, Ptr{facetT}, Ptr{facetT}, Cuint), qh, fp, format, facetA, facetB, printall)
end

function qh_produce_output(qh)
    ccall((:qh_produce_output, libqhull_r), Cvoid, (Ptr{qhT},), qh)
end

function qh_readpoints(qh, numpoints, dimension, ismalloc)
    ccall((:qh_readpoints, libqhull_r), Ptr{Cdouble}, (Ptr{qhT}, Ptr{Cint}, Ptr{Cint}, Ptr{Cuint}), qh, numpoints, dimension, ismalloc)
end

function qh_check_output(qh)
    ccall((:qh_check_output, libqhull_r), Cvoid, (Ptr{qhT},), qh)
end

function qh_check_points(qh)
    ccall((:qh_check_points, libqhull_r), Cvoid, (Ptr{qhT},), qh)
end

function qh_facetvertices(qh, facetlist, facets, allfacets)
    ccall((:qh_facetvertices, libqhull_r), Ptr{setT}, (Ptr{qhT}, Ptr{facetT}, Ptr{setT}, Cuint), qh, facetlist, facets, allfacets)
end

function qh_findbestfacet(qh, point, bestoutside, bestdist, isoutside)
    ccall((:qh_findbestfacet, libqhull_r), Ptr{facetT}, (Ptr{qhT}, Ptr{Cdouble}, Cuint, Ptr{Cdouble}, Ptr{Cuint}), qh, point, bestoutside, bestdist, isoutside)
end

function qh_nearvertex(qh, facet, point, bestdistp)
    ccall((:qh_nearvertex, libqhull_r), Ptr{vertexT}, (Ptr{qhT}, Ptr{facetT}, Ptr{Cdouble}, Ptr{Cdouble}), qh, facet, point, bestdistp)
end

function qh_point(qh, id)
    ccall((:qh_point, libqhull_r), Ptr{Cdouble}, (Ptr{qhT}, Cint), qh, id)
end

function qh_pointfacet(qh)
    ccall((:qh_pointfacet, libqhull_r), Ptr{setT}, (Ptr{qhT},), qh)
end

function qh_pointid(qh, point)
    ccall((:qh_pointid, libqhull_r), Cint, (Ptr{qhT}, Ptr{Cdouble}), qh, point)
end

function qh_pointvertex(qh)
    ccall((:qh_pointvertex, libqhull_r), Ptr{setT}, (Ptr{qhT},), qh)
end

function qh_setvoronoi_all(qh)
    ccall((:qh_setvoronoi_all, libqhull_r), Cvoid, (Ptr{qhT},), qh)
end

function qh_triangulate(qh)
    ccall((:qh_triangulate, libqhull_r), Cvoid, (Ptr{qhT},), qh)
end

function qh_rboxpoints(qh, rbox_command)
    ccall((:qh_rboxpoints, libqhull_r), Cint, (Ptr{qhT}, Ptr{Cchar}), qh, rbox_command)
end

function qh_errexit_rbox(qh, exitcode)
    ccall((:qh_errexit_rbox, libqhull_r), Cvoid, (Ptr{qhT}, Cint), qh, exitcode)
end

struct __JL_Ctag_9
    data::NTuple{8, UInt8}
end

function Base.getproperty(x::Ptr{__JL_Ctag_9}, f::Symbol)
    f === :area && return Ptr{Cdouble}(x + 0)
    f === :replace && return Ptr{Ptr{facetT}}(x + 0)
    f === :samecycle && return Ptr{Ptr{facetT}}(x + 0)
    f === :newcycle && return Ptr{Ptr{facetT}}(x + 0)
    f === :trivisible && return Ptr{Ptr{facetT}}(x + 0)
    f === :triowner && return Ptr{Ptr{facetT}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_9, f::Symbol)
    r = Ref{__JL_Ctag_9}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_9}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_9}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const qhDEFlibqhull = 1

const qhDEFuser = 1

const qh_FILENAMElen = 500

const MSG_TRACE0 = 0

const MSG_TRACE1 = 1000

const MSG_TRACE2 = 2000

const MSG_TRACE3 = 3000

const MSG_TRACE4 = 4000

const MSG_TRACE5 = 5000

const MSG_ERROR = 6000

const MSG_WARNING = 7000

const MSG_STDERR = 8000

const MSG_OUTPUT = 9000

const MSG_QHULL_ERROR = 10000

const MSG_FIX = 11000

const MSG_MAXLEN = 3000

const qh_OPTIONline = 80

const REALfloat = 0

const realT = Float64

const REALmax = DBL_MAX

const REALmin = DBL_MIN

const REALepsilon = DBL_EPSILON

const qh_REALdigits = 16

const qh_REAL_1 = "%6.16g "

const qh_REAL_2n = "%6.16g %6.16g\n"

const qh_REAL_3n = "%6.16g %6.16g %6.16g\n"

const DEFcountT = 1

const COUNTmax = INT_MAX

const qh_POINTSmax = INT_MAX - 16

const qh_CLOCKtype = 1

const qh_RANDOMtype = 5

const qh_RANDOMmax = realT(Culong(2147483646))

const qh_ORIENTclock = 0

const qh_JOGGLEdefault = 30000.0

const qh_JOGGLEincrease = 10.0

const qh_JOGGLEretry = 2

const qh_JOGGLEagain = 1

const qh_JOGGLEmaxincrease = 0.01

const qh_JOGGLEmaxretry = 50

const qh_HASHfactor = 2

const qh_VERIFYdirect = 1000000

const qh_INITIALsearch = 6

const qh_INITIALmax = 8

# Skipping MacroDefinition: qh_MEMalign ( ( int ) ( fmax_ ( sizeof ( realT ) , sizeof ( void * ) ) ) )

const qh_MEMbufsize = 0x00010000

const qh_MEMinitbuf = 0x00020000

const qh_INFINITE = -10.101

const qh_DEFAULTbox = 0.5

const qh_DEFAULTzbox = 1.0e6

const qh_COMPUTEfurthest = 0

const qh_KEEPstatistics = 1

const qh_MAXoutside = 1

const qh_QUICKhelp = 0

const qh_BESTcentrum = 20

const qh_BESTcentrum2 = 2

const qh_BESTnonconvex = 15

const qh_COPLANARratio = 3

const qh_DIMmergeVertex = 6

const qh_DIMreduceBuild = 5

const qh_MAXcheckpoint = 10

const qh_MAXcoplanarcentrum = 10

const qh_MAXnewcentrum = 5

const qh_MAXnewmerges = 2

const qh_RATIOconcavehorizon = 20.0

const qh_RATIOconvexmerge = 10.0

const qh_RATIOcoplanarapex = 3.0

const qh_RATIOcoplanaroutside = 30.0

const qh_RATIOmaxsimplex = 0.001

const qh_RATIOnearinside = 5

const qh_RATIOpinchedsubridge = 10.0

const qh_RATIOtrypinched = 4.0

const qh_RATIOtwisted = 20.0

const qh_MAXnarrow = -0.99999999

const qh_WARNnarrow = -0.999999999999999

const qh_WIDEcoplanar = 6

const qh_WIDEduplicate = 100

const qh_WIDEdupridge = 50

const qh_WIDEmaxoutside = 100

const qh_WIDEmaxoutside2 = 10qh_WIDEmaxoutside

const qh_WIDEpinched = 100

const qh_ZEROdelaunay = 2

const qhDEFmem = 1

const DEFsetT = 1

const DEFqhT = 1

const qhmem_ERRmem = 4

const qhmem_ERRqhull = 5

const qhDEFset = 1

# Skipping MacroDefinition: SETelemsize ( ( int ) sizeof ( setelemT ) )

const coordT = realT

const pointT = coordT

const flagT = Cuint

const boolT = Cuint

const False = 0

const True = 1

const qh_False = 0

const qh_True = 1

const qhDEFstat = 1

const DEFqhstatT = 1

const qh_ALL = True

const qh_NOupper = True

const qh_IScheckmax = True

const qh_ISnewfacets = True

const qh_RESETvisible = True

const qh_ERRnone = 0

const qh_ERRinput = 1

const qh_ERRsingular = 2

const qh_ERRprec = 3

const qh_ERRmem = 4

const qh_ERRqhull = 5

const qh_ERRother = 6

const qh_ERRtopology = 7

const qh_ERRwide = 8

const qh_ERRdebug = 9

# Skipping MacroDefinition: qh_FILEstderr ( ( FILE * ) 1 )

const qh_MAXnummerge = 511

const QHULL_NON_REENTRANT = 0

const QHULL_QH_POINTER = 1

const QHULL_REENTRANT = 2

const QHULL_LIB_TYPE = QHULL_REENTRANT

# Skipping MacroDefinition: QHULL_LIB_CHECK qh_lib_check ( QHULL_LIB_TYPE , sizeof ( qhT ) , sizeof ( vertexT ) , sizeof ( ridgeT ) , sizeof ( facetT ) , sizeof ( setT ) , sizeof ( qhmemT ) ) ;

# Skipping MacroDefinition: QHULL_LIB_CHECK_RBOX qh_lib_check ( QHULL_LIB_TYPE , sizeof ( qhT ) , sizeof ( vertexT ) , sizeof ( ridgeT ) , sizeof ( facetT ) , 0 , 0 ) ;

# Skipping MacroDefinition: FORALLfacets for ( facet = qh -> facet_list ; facet && facet -> next ; facet = facet -> next )

# Skipping MacroDefinition: FORALLvertices for ( vertex = qh -> vertex_list ; vertex && vertex -> next ; vertex = vertex -> next )


<table>
    <thead>
        <tr>
            <th>No</th>
            <th>Tanggal</th>
            <th>Kas</th>
            <th>Transaksi</th>
            <th>Jumlah Tambah</th>
            <th>Jumlah Kurang</th>
        </tr>
    </thead>
    <tbody>
        @php
            $totalTambah = 0;
            $totalKurang = 0;
        @endphp
        @foreach ($data_profit as $index => $entry)
        <tr>
            <td>{{ $index + 1 }}</td>
            <td>{{ $entry->date }}</td>
            <td>{{ $entry->cash->name ?? 'N/A' }}</td>
            <td>
                @if($entry->transaction_id)
                    {{ $entry->transaction->name ?? 'N/A' }}
                @elseif($entry->order_id)
                    Penjualan - {{ $entry->order->description ?? 'N/A' }}
                @elseif($entry->purchase_id)
                    Pembelian - {{ $entry->purchase->description ?? 'N/A' }}
                @else
                    'N/A'
                @endif
            </td>
            <!-- Jangan gunakan number_format di Excel -->
            <td>
                @php
                    if ($entry->category === 'tambah') {
                        $totalTambah += $entry->amount;
                    }
                @endphp
                {{ $entry->category === 'tambah' ? $entry->amount : '-' }}
            </td>
            <td>
                @php
                    if ($entry->category === 'kurang') {
                        $totalKurang += $entry->amount;
                    }
                @endphp
                {{ $entry->category === 'kurang' ? $entry->amount : '-' }}
            </td>
        </tr>
        @endforeach
    </tbody>
    <tfoot>
        <tr>
            <td colspan="4" style="text-align: right;"><strong>Total</strong></td>
            <td><strong>{{ $totalTambah }}</strong></td>
            <td><strong>{{ $totalKurang }}</strong></td>
        </tr>
    </tfoot>
</table>
